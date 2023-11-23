extends CharacterBody3D

@export var animation_frame = 0
var facing = 0
const FRAMES = 3
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = ($SpringArm3D.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	update_facing(input_dir)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func update_facing(direction):
	# Start and Stop Animation based on input
	if direction != Vector2(0,0):
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
		animation_frame = 0
	
	# Set Facing and Horizontal Flip depending on input direction
	if direction.x == -1:
		$Sprite3D.flip_h = false
		facing = 2
	elif direction.x == 1:
		$Sprite3D.flip_h = true
		facing = 2
	elif direction.y == 1:
		facing = 0
	elif direction.y == -1:
		facing = 1
	
	# Update the frame dynamically for animation
	$Sprite3D.frame = animation_frame + (facing * FRAMES)
