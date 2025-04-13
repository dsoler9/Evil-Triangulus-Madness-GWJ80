extends RigidBody2D

var grabbed := false
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var grab_sound: AudioStreamPlayer2D = $GrabSound

signal piece_placed

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("mouse button pressed")
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				grab()
			else:
				drop()

func _physics_process(delta):
	if grabbed:
		global_transform.origin = get_global_mouse_position()
	

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
	animations.stop()
	#grab_sound.stop()
	emit_signal("piece_placed")
	
