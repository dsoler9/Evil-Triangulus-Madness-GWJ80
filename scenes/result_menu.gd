extends Control

@onready var mouse_cursor: Sprite2D = $MouseCursor
@onready var result_title: RichTextLabel = $ResultTitle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	if Global.result_title_text != "":
		result_title.text = Global.result_title_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()


func _on_continue_btn_pressed() -> void:
	Global.player_lives = 3
	Global.enemy_lives = 3
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
