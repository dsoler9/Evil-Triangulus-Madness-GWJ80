extends Sprite2D

const SPAWN_POSITIONS = [Vector2(192, 100), Vector2(576, 100), Vector2(1344, 100), Vector2(1728, 100)]

var tween: Tween
signal reached_position(spawn_pos: Vector2)

func move_to_spawn_position():
	var target_pos = SPAWN_POSITIONS[randi_range(0, SPAWN_POSITIONS.size() - 1)]
	
	tween.kill()  # Por si ya hay algo animándose
	tween.tween_property(self, "position", target_pos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.connect("finished", Callable(self, "_on_tween_finished").bind(target_pos), ConnectFlags.CONNECT_ONE_SHOT)

func _on_tween_finished(target_pos: Vector2):
	emit_signal("reached_position", target_pos)
