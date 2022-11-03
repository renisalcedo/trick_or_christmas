extends Character

# Character Physics Properties
const JUMP_FORCE := 1200
const MAX_FALL_SPEED := 500
const UP := Vector2(0, -1)

# Player Properties
var player_attacks := PlayerAttacks.new()

func _physics_process(delta):
	move_and_slide(motion, UP)
	player_move_input()

func player_move_input() -> void:
	""" Handles player input for movement """
	# JUMP Movement Input
	if is_on_floor():
		motion.y = 0
		if Input.is_action_pressed("jump"):
			motion.y = -JUMP_FORCE
	else:
		# Apply Gravity when in the air or falling
		motion.y += GRAVITY
		if motion.y > MAX_FALL_SPEED:
			motion.y = MAX_FALL_SPEED

	# Horizontal Movement Input
	if Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x - speed, -max_speed, 0)
	elif Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x + speed, 0, max_speed)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

func move_player_back() -> void:
	""" Moves the player back when they hit an enemy """
	motion.x = -max_speed * 10

func _on_FallAttackArea_body_entered(body: KinematicBody2D):
	if body and "Enemy" in body.name:
		var damage = player_attacks.handle_jump_attack()
		body.take_damage(damage)
		move_player_back()