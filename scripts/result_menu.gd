extends Control

@onready var mouse_cursor: Sprite2D = $MouseCursor
@onready var result_title: RichTextLabel = $ResultTitle
@onready var result_menu_music: AudioStreamPlayer2D = $ResultMenuMusic
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMusic.stop_music()
	animation_player.play("fade_in")
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	if Global.result_title_text != "":
		result_title.text = Global.result_title_text
	
	if Global.enemy_lives == 0:
		animated_sprite_2d.play("default")
		result_menu_music.stream = preload("res://assets/music/Galaxy trip.mp3")
	else:
		animated_sprite_2d.play("bad")
		result_menu_music.stream = preload("res://assets/music/Forgotten Heroes.mp3")
		
	result_menu_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_cursor.global_position = get_viewport().get_mouse_position()


func _on_continue_btn_pressed() -> void:
	Global.player_lives = 3
	Global.enemy_lives = 3
	Global.current_background = preload("res://assets/backgrounds/city 5/7.png")
	animation_player.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_btn_pressed() -> void:
	animation_player.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
