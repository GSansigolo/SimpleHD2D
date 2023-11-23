extends SpringArm3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_camera()
	handle_zoom()

func handle_camera():
	if Input.is_action_just_pressed("rotate_left"):
		# self.rotate_y(self.rotation.y + PI/2)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self,"rotation:y", self.rotation.y + PI/2, 0.5)
	elif Input.is_action_just_pressed("rotate_right"):
		# self.rotate_y(self.rotation.y - PI/2)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self,"rotation:y", self.rotation.y - PI/2, 0.5)
	# reset rotation
	elif Input.is_action_pressed("rotate_right") and Input.is_action_pressed("rotate_left"):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self,"rotation:y", PI, 0.5)

func handle_zoom():
	if Input.is_action_just_pressed("zoom_in"):
		
		if int(spring_length)>0:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_OUT)
			var newlength = int(spring_length) - 1
			tween.tween_property(self,"spring_length", newlength, 0.5)
			if int(newlength) <= 0:
				tween.tween_property(self,"position", Vector3(0,0.2,0), 0.5)

	elif Input.is_action_just_pressed("zoom_out"):
		if int(spring_length)<6:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_OUT)
			var newlength = int(spring_length) + 1
			tween.tween_property(self,"spring_length", newlength, 0.5)
			if int(newlength) > 0:
				tween.tween_property(self,"position", Vector3(0,0,0), 0.5)
