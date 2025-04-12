extends RigidBody2D

var grabbed := false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				grabbed = true
				print("grab")
				#freeze = true
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				print("drop")
				grabbed = false
				#freeze = false

func _process(delta):
	if grabbed:
		global_position = get_global_mouse_position()
	
