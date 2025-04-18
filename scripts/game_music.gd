extends AudioStreamPlayer2D

@onready var game_music: AudioStreamPlayer2D = $"."

# Called when the node enters the scene tree for the first time.
func play_music():
	game_music.play()

func stop_music():
	game_music.stop()
