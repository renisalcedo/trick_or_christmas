extends BaseEnemy

# Animations Signal
signal animate_skeleton(current_animation)

var time = 0
var animation_switch = 0

func _physics_process(delta):
	apply_physics(delta)

func _process(delta):
	walk_around(delta)

func walk_around(delta):
	""" Walk around and animate movement """
	time += delta
	var seconds = fmod(time, 60)

	if int(seconds) % 3 == 0:
		animation_switch += 1

		if animation_switch == 2:
			animation_switch = 0

	match animation_switch:
		1:
			emit_signal("animate_skeleton", "walk_around", motion)
			motion.x = clamp(motion.x + speed, 0, max_speed)
		2:
			emit_signal("animate_skeleton", "walk_around", motion)
			motion.x = clamp(motion.x - speed, -max_speed, 0)
		_:
			emit_signal("animate_skeleton", "idle", motion)
			motion.x = 0

func apply_physics(delta):
	""" Apply physics to the enemy """
	# Move the enemy
	motion.y += GRAVITY * delta
	move_and_slide(motion, Vector2.UP)
	
	# Check if the enemy is on the ground
	if is_on_floor():
		motion.y = 0
