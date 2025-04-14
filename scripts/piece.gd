extends RigidBody2D

var grabbed := false
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var grab_sound: AudioStreamPlayer2D = $GrabSound

const GRAB_Y_LIMIT = 200

signal piece_placed

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos = get_viewport().get_mouse_position()
				if mouse_pos.y <= GRAB_Y_LIMIT:
					grab()
			else:
				drop()

func _physics_process(delta):
	if grabbed:
		var mouse_pos = get_global_mouse_position()
		# Limitar la Y del mouse si está por debajo del límite
		if mouse_pos.y > GRAB_Y_LIMIT:
			mouse_pos.y = GRAB_Y_LIMIT
		
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			drop()
		
		global_transform.origin = mouse_pos
	

func grab():
	#print("grab")
	grabbed = true
	freeze = true
	animations.play("grabbed")
	#grab_sound.play()

func drop():
	#print("drop")
	grabbed = false
	freeze = false
	input_pickable = false
	animations.stop()
	#grab_sound.stop()
	emit_signal("piece_placed")
	
