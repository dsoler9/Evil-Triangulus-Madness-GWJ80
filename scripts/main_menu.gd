extends Control

@onready var background: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_menu_music: AudioStreamPlayer2D = $MainMenuMusic
@onready var mouse_cursor: Sprite2D = $MouseCursor

var current_color: Color
var target_color: Color
var transition_speed := 0.3

func _ready():
	animation_player.play("fade_in")
	current_color = random_color()
	target_color = random_color()
	background.color = current_color
	Global.player_lives = 3
	Global.enemy_lives = 3
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _process(delta):
	mouse_cursor.global_position = get_viewport().get_mouse_position()
	
	current_color = current_color.lerp(target_color, delta * transition_speed)
	background.color = current_color
	
	if abs(current_color.r - target_color.r) < 0.01 and abs(current_color.g - target_color.g) < 0.01 and abs(current_color.b - target_color.b) < 0.01:
		target_color = Color(randf(), randf(), randf())

func random_color():
	return Color(
		randf() * 0.5,  # R entre 0.3 y 1.0
		randf() * 0.5,  # G entre 0.3 y 1.0
		randf() * 0.5   # B entre 0.3 y 1.0
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	if anim_name == "fade_in":
		animation_player.play("tuto_animations")
