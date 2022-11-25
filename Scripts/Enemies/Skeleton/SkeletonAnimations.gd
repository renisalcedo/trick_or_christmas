extends AnimationPlayer

func _on_EnemySkeleton_animate_skeleton(current_animation: String, motion: Vector2) -> void:
	match current_animation:
		"walk_around":
			walk_around(motion)
		_:
			play(current_animation)

func walk_around(motion) -> void:
	if motion.x == 500 or motion.x == -500:
		play("idle")
		get_parent().get_node("Head").flip_h = false
	if motion.x > 0:
		get_parent().get_node("Head").flip_h = false
		play("Walking")
	elif motion.x < 0:
		get_parent().get_node("Head").flip_h = true
		play("Walking")
