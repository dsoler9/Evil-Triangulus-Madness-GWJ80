extends CharacterBody2D

@export var speed: float = 600.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var lerp_strength: float = 10.0

## VARIABLES
var lanes = [192.0, 576.0, 960.0, 1344.0, 1728.0]
var current_lane = 2
var target_x: float
var current_speed := 0.0

## PRINCIPAL FUNCTIONS
func _ready():
	position.x = 960.0

func _physics_process(delta):
	#if Input.is_action_just_pressed("right") and current_lane < len(lanes) - 1:
		#current_lane += 1
	#elif Input.is_action_just_pressed("left") and current_lane > 0:
		#current_lane -= 1
#
	#target_x = lanes[current_lane]
#
	#position.x = lerp(position.x, target_x, speed * delta)
	var input_dir = 0
	if Input.is_action_pressed("right"):
		input_dir += 1
	if Input.is_action_pressed("left"):
		input_dir -= 1
	
	var target_speed = input_dir * speed
	current_speed = lerp(current_speed, target_speed, lerp_strength * delta)
	
	position.x += current_speed * delta
