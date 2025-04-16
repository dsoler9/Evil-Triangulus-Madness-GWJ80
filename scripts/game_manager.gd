extends Node

@onready var mouse_cursor: Sprite2D = $MouseCursor
#@export var piece_scene: PackedScene
@export var piece_scenes: Array[PackedScene] = []
@onready var pieces_node: Node2D = $"../Pieces"
@onready var texture_rect: TextureRect = $"../TextureRect"

var current_piece: RigidBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	randomize()
	spawn_piece()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()

func spawn_piece():
	if piece_scenes.is_empty():
		push_error("There is no pieces")
		return
	
	var random_index = randi() % piece_scenes.size()
	var scene = piece_scenes[random_index]
	
	#current_piece = piece_scene.instantiate()
	var new_piece = scene.instantiate()
	pieces_node.add_child(new_piece)
	#pieces_node.add_child(current_piece)
	
	## TODO - Have to put it in another position
	#current_piece.global_position = Vector2(400, 100)
	#current_piece.freeze = true
	new_piece.global_position = Vector2(1848.0, 145.0)
	new_piece.freeze = true
	
	new_piece.connect("piece_placed", Callable(self, "_on_piece_placed"))
	current_piece = new_piece

func _on_piece_placed():
	current_piece = null
	spawn_piece()
