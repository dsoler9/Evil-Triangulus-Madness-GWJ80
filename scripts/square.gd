extends RigidBody2D

signal piece_placed

var already_emitted := false
@onready var already_frozen := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mat = PhysicsMaterial.new()
	mat.friction = 1.5
	mat.bounce = 0.0
	physics_material_override = mat
	linear_damp = 2.0
	angular_damp = 4.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	linear_velocity.y = 200
	
	#if not already_emitted and position.y < 0:
		#already_emitted = true
		#emit_signal("piece_placed")


#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if already_frozen:
		#return
	#
	## Asegurarse de que tocamos al jugador o a una pieza ya colocada
	#if body.name == "Player":
		#call_deferred("attach_to_player", body) 
	#elif body.get_parent() and body.get_parent().name == "PieceContainer":
		#call_deferred("attach_to_player", body.get_parent().get_parent())

#func attach_to_player(player: Node):
	#already_frozen = true
	#
	## Freeze la física
	##freeze = true
	#
	## Re-parent la pieza al PiecesContainer
	#var pieces_container = player.get_node("PieceContainer")
	#var global_pos = global_position  # Guardamos antes del cambio
	#get_parent().remove_child(self)
	#pieces_container.add_child(self)
	#global_position = global_pos  # Restauramos la posición
	#
	## Emitir si quieres seguir generando nuevas
	#emit_signal("piece_placed")
