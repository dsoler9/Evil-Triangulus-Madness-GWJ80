extends Node

const SPAWN_FOOD_POSITIONS = [192.0, 576.0, 960.0, 1344.0, 1728.0]

@export var piece_scenes: Array[PackedScene] = []
@export var current_fall_speed = 200
@onready var pieces_node: Node2D = $"../Pieces"
@onready var spawn_piece_timer: Timer = $"../SpawnPieceTimer"

var current_piece: RigidBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_piece_timer.start()

func spawn_piece():
	if piece_scenes.is_empty():
		push_error("There is no pieces")
		return
	
	var random_index = randi() % piece_scenes.size()
	var scene = piece_scenes[random_index]
	
	var new_piece = scene.instantiate()
	pieces_node.add_child(new_piece)
	
	var random_position = SPAWN_FOOD_POSITIONS[randi_range(0, 2)]
	new_piece.global_position = Vector2(random_position, 200)
	
	new_piece.connect("piece_placed", Callable(self, "_on_piece_placed"))
	current_piece = new_piece

func _on_piece_placed():
	current_piece = null

func _on_spawn_piece_timer_timeout() -> void:
	randomize()
	spawn_piece()
