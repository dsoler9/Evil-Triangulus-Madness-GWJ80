extends Control

@onready var background: ColorRect = $ColorRect

var current_color: Color
var target_color: Color
var transition_speed := 0.3

func _ready():
	current_color = random_color()
	target_color = random_color()
	background.color = current_color
	Global.player_lives = 3

func _process(delta):
	current_color = current_color.lerp(target_color, delta * transition_speed)
	background.color = current_color
	
	if abs(current_color.r - target_color.r) < 0.01 and abs(current_color.g - target_color.g) < 0.01 and abs(current_color.b - target_color.b) < 0.01:
		target_color = Color(randf(), randf(), randf())

func random_color():
	return Color(
		0.3 + randf() * 0.7,  # R entre 0.3 y 1.0
		0.3 + randf() * 0.7,  # G entre 0.3 y 1.0
		0.3 + randf() * 0.7   # B entre 0.3 y 1.0
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
