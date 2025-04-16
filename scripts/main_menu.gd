extends Control

@onready var background: ColorRect = $ColorRect

var current_color: Color
var target_color: Color
var transition_speed := 1.5

func _ready():
	current_color = background.color
	target_color = _generate_random_color()

func _process(delta):
	current_color = current_color.lerp(target_color, delta * transition_speed)
	background.color = current_color
	
	if _colors_are_close(current_color, target_color):
		target_color = _generate_random_color()

func _generate_random_color() -> Color:
	return Color(randf_range(0.2, 1.0), randf_range(0.2, 1.0), randf_range(0.2, 1.0), 1.0)

func _colors_are_close(c1: Color, c2: Color, threshold := 0.01) -> bool:
	return abs(c1.r - c2.r) < threshold \
		and abs(c1.g - c2.g) < threshold \
		and abs(c1.b - c2.b) < threshold

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
