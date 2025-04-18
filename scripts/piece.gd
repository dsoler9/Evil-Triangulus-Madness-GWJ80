extends RigidBody2D

var grabbed := false
var dropped := false
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var grab_sound: AudioStreamPlayer2D = $GrabSound
@onready var drop_ray_cast: RayCast2D = $DropRayCast
@onready var shadow_sprite: Sprite2D = $ShadowSprite
@export var fall_speed = 150.0
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var piece_placed_sound: AudioStreamPlayer2D = $PiecePlacedSound

const GRAB_Y_LIMIT = 200

signal piece_placed
signal player_should_lose_life

func _ready() -> void:
	get_parent().add_child(shadow_sprite)
	shadow_sprite.owner = get_parent()
	update_fall_speed()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				grab()
				#var mouse_pos = get_viewport().get_mouse_position()
				#if mouse_pos.y <= GRAB_Y_LIMIT:
					
			else:
				drop()

func _physics_process(delta):
	if grabbed:
		var mouse_pos = get_global_mouse_position()
		
		#if mouse_pos.y > GRAB_Y_LIMIT:
			#mouse_pos.y = GRAB_Y_LIMIT
		
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			drop()
		
		if Input.is_action_just_pressed("rotate"):
			rotate(deg_to_rad(90))
			drop_ray_cast.rotate(deg_to_rad(-90))
		
		global_transform.origin = mouse_pos
		if drop_ray_cast.is_colliding():
			var hit_pos = drop_ray_cast.get_collision_point()
			var shadow_height = shadow_sprite.texture.get_height() * shadow_sprite.scale.y / 2.0
			
			# Reposicionar la sombra justo ENCIMA del punto de colisión
			shadow_sprite.global_position = hit_pos - Vector2(0, shadow_height)
	if not dropped:
		linear_velocity.y = fall_speed

func grab():
	#print("grab")
	grabbed = true
	freeze = true
	animations.play("grabbed")
	grab_sound.play()
	shadow_sprite.visible = true

func drop():
	#print("drop")
	dropped = true
	grabbed = false
	freeze = false
	input_pickable = false
	animations.stop()
	grab_sound.stop()
	shadow_sprite.visible = false
	linear_velocity = Vector2.ZERO
	emit_signal("piece_placed")
	
func update_shadow_position():
	if drop_ray_cast.is_colliding():
		var collision_point = drop_ray_cast.get_collision_point()
		shadow_sprite.global_position = Vector2(global_position.x, collision_point.y)
		shadow_sprite.visible = true
	else:
		shadow_sprite.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Ground":
		hurt_sound.play()
		await get_tree().create_timer(0.2).timeout
		Global.player_lives -= 1
		if not Global.player_lives == 0:
			get_tree().reload_current_scene()
		else:
			await Global.update_result_title(false)
			get_tree().change_scene_to_file("res://scenes/result_menu.tscn")
	else:
		piece_placed_sound.play()

func update_fall_speed() -> void:
	match Global.enemy_lives:
		3:
			fall_speed = 150.0
		2:
			fall_speed += 150.0
		1:
			fall_speed += 300.0
