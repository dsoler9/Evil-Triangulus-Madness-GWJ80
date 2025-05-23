extends Node

var player_lives = 3
var enemy_lives = 3
var result_title_text: String
var current_background = preload("res://assets/backgrounds/city 5/7.png")
var bad_ending_sprite = preload("res://assets/characters/evil_evil_triangulus.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_result_title(won: bool) -> void:
	if won:
		result_title_text = "[wave][rainbow freq=0.3]YOU WON[/rainbow][/wave]\nAGAINST[shake rate=20.0 level=20][color=#a020f0]\nEVIL TRIANGULUS[/color][/shake]"
	else:
		result_title_text = "[shake rate=20.0 level=20][color=#ff0000]YOU LOSE[/color][/shake][color=orange]\nAGAINST[/color][shake rate=20.0 level=20][color=yellow]\nEVIL TRIANGULUS[/color][/shake]"
