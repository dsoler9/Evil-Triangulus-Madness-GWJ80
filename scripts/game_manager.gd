extends Node

const SPAWN_PIECES_POSITIONS = [192.0, 576.0, 1344.0, 1728.0]

@onready var mouse_cursor: Sprite2D = $MouseCursor
@export var piece_scenes: Array[PackedScene] = []
@onready var pieces_node: Node2D = $"../Pieces"
@onready var spawn_piece_timer: Timer = $"../SpawnPieceTimer"
@onready var evil_triangulus: Sprite2D = $EvilTriangulus
@onready var delay: Timer = $"../Delay"
@onready var enemy_ui: CanvasLayer = $EnemyUI

var current_piece: RigidBody2D = null
var piece_done_damage: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	spawn_piece_timer.start()
	piece_done_damage = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()

func spawn_piece():
	if piece_scenes.is_empty():
		push_error("There is no pieces")
		return
	
	var random_index = randi() % piece_scenes.size()
	var scene = piece_scenes[random_index]
	
	var new_piece = scene.instantiate()
	new_piece.add_to_group("Pieces")
	pieces_node.add_child(new_piece)
	
	var random_position = SPAWN_PIECES_POSITIONS[randi_range(0, 2)]
	evil_triangulus.global_position = Vector2(random_position, 200)
	new_piece.global_position = Vector2(random_position, 300)
	
	new_piece.connect("piece_placed", Callable(self, "_on_piece_placed"))
	current_piece = new_piece

func _on_piece_placed():
	current_piece = null

func _on_spawn_piece_timer_timeout() -> void:
	randomize()
	spawn_piece()

func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pieces") and not piece_done_damage:
		Global.enemy_lives -= 1
		if not Global.enemy_lives == 0:
			piece_done_damage = true
			get_tree().reload_current_scene()
		else:
			await Global.update_result_title(true)
			get_tree().change_scene_to_file("res://scenes/result_menu.tscn")
