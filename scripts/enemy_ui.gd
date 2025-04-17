extends CanvasLayer

@onready var heart_1: TextureRect = $HBoxContainer/Heart1
@onready var heart_2: TextureRect = $HBoxContainer/Heart2
@onready var heart_3: TextureRect = $HBoxContainer/Heart3

@export var full_heart: Texture2D
@export var empty_heart: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_hearts(Global.enemy_lives)

func update_hearts(lives):
	var hearts = [heart_1, heart_2, heart_3]
	for i in range(3):
		if i < lives:
			hearts[i].texture = full_heart
		else:
			hearts[i].texture = empty_heart
