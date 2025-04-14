extends Node2D

const GRAB_Y_LIMIT = 200
const DASH_LENGTH = 10
const SPACE_LENGTH = 5
const LINE_COLOR = Color(0.1, 0.15, 0.25)  # Rojo un poco más suave
const LINE_WIDTH = 2.5
const TEXT_COLOR = Color(1, 1, 1)
const SHADOW_COLOR = Color(0.2, 0.3, 0.45, 0.4)

@export var font: Font

func _ready():
	queue_redraw()

func _draw():
	var viewport_width = get_viewport_rect().size.x
	var x := 0
	while x < viewport_width:
		draw_line(
			Vector2(x, GRAB_Y_LIMIT),
			Vector2(x + DASH_LENGTH, GRAB_Y_LIMIT),
			LINE_COLOR,
			LINE_WIDTH
		)
		x += DASH_LENGTH + SPACE_LENGTH
		
	var text := "DROP ZONE"
	if font:
		var text_size = font.get_string_size(text)
		var pos = Vector2(
			(viewport_width - text_size.x) / 2,
			GRAB_Y_LIMIT - 10  # Un poco por encima de la línea
		)
		
		# Sombra
		draw_string(font, pos + Vector2(1, 1), text, HORIZONTAL_ALIGNMENT_CENTER, -1, 30, SHADOW_COLOR)
		
		# Texto principal
		draw_string(font, pos, text, HORIZONTAL_ALIGNMENT_CENTER, -1, 30, TEXT_COLOR)
		
		
		
