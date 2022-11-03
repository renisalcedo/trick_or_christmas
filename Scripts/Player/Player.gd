extends Character

func _physics_process(delta):
	move_and_slide(motion)

func player_move_input():
	if Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x - speed, -max_speed, 0)
	elif Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x + speed, 0, max_speed)
	else:
		motion.x = lerp(motion.x, 0, friction)