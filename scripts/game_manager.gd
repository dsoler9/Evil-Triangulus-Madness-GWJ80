extends Node

const SPAWN_PIECES_POSITIONS = [192.0, 576.0, 1344.0, 1728.0]

@onready var mouse_cursor: Sprite2D = $MouseCursor
@export var piece_scenes: Array[PackedScene] = []
@onready var pieces_node: Node2D = $"../Pieces"
@onready var spawn_piece_timer: Timer = $"../SpawnPieceTimer"
@onready var enemy_ui: CanvasLayer = $EnemyUI
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var hurt_enemy_sound: AudioStreamPlayer2D = $"../HurtEnemySound"
@onready var background: TextureRect = $"../GameBackground"
@onready var evil_triangulus_animated_sprite: AnimatedSprite2D = $EvilTriangulus/EvilTriangulusAnimatedSprite
@onready var evil_triangulus: Node2D = $EvilTriangulus
@onready var damage_zone: Area2D = $"../DamageZone"

var current_piece: RigidBody2D = null
var piece_done_damage: bool
var can_deal_dmg = false
var tower_checkpoint_1 = false
var tower_checkpoint_2 = false
var tower_checkpoint_3 = false
var spawn_time = 4.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	animation_player.play("fade_in")
	if not GameMusic.playing:
		GameMusic.play_music()
		
	if Global.enemy_lives == 2:
		spawn_piece_timer.wait_time = 3.0
	elif Global.enemy_lives == 1:
		spawn_piece_timer.wait_time = 2.0
		
	spawn_piece_timer.start()
	piece_done_damage = false
	background.texture = Global.current_background

func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()
	
	if tower_checkpoint_1 and tower_checkpoint_2 and tower_checkpoint_3:
		can_deal_dmg = true
		damage_zone.monitoring = true

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
	evil_triangulus_animated_sprite.play("attack")
	await get_tree().create_timer(0.5).timeout
	evil_triangulus_animated_sprite.play("idle")
	
	
	new_piece.connect("piece_placed", Callable(self, "_on_piece_placed"))
	current_piece = new_piece

#region SIGNALS
func _on_piece_placed():
	current_piece = null

func _on_spawn_piece_timer_timeout() -> void:
	randomize()
	spawn_piece()

func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pieces") and not piece_done_damage:
		if can_deal_dmg:
			hurt_enemy_sound.play()
			Global.enemy_lives -= 1
			
			if not Global.enemy_lives == 0:
				piece_done_damage = true
				animation_player.play("fade_out")
				await get_tree().create_timer(1.0).timeout
				
				if Global.enemy_lives == 2:
					Global.current_background = preload("res://assets/backgrounds/city 2/10.png")
				
				if Global.enemy_lives == 1:
					Global.current_background = preload("res://assets/backgrounds/city 1/10.png")
					
				spawn_piece_timer.wait_time -= 1.0
				get_tree().reload_current_scene()
					
			else:
				Global.update_result_title(true)
				animation_player.play("fade_out")
				await get_tree().create_timer(1.0).timeout
				get_tree().change_scene_to_file("res://scenes/result_menu.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		animation_player.play("triangulus_floating")

func _on_tower_checkpoint_1_body_entered(body: Node2D) -> void:
	tower_checkpoint_1 = true


func _on_tower_checkpoint_1_body_exited(body: Node2D) -> void:
	tower_checkpoint_1 = false


func _on_tower_checkpoint_2_body_entered(body: Node2D) -> void:
	if tower_checkpoint_1:
		tower_checkpoint_2 = true
	else:
		tower_checkpoint_2 = false


func _on_tower_checkpoint_3_body_entered(body: Node2D) -> void:
	if tower_checkpoint_1 and tower_checkpoint_2:
		tower_checkpoint_3 = true
	else:
		tower_checkpoint_3 = false
#endregion
