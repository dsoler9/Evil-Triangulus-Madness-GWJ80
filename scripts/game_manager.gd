extends Node

@onready var mouse_cursor: Sprite2D = $MouseCursor

#var held_object = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	#for node in get_tree().get_nodes_in_group("pickable"):
		#node.clicked.connect(_on_piece_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()

#func _unhandled_input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if held_object and !event.pressed:
			#held_object.drop(Input.get_last_mouse_velocity())
			#held_object = null
#
#
#func _on_piece_clicked(object):
	#if !held_object:
		#object.pickup()
		#held_object = object
