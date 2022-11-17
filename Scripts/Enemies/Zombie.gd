extends "res://Scripts/Classes/BaseEnemy.gd"

var velocity = Vector2(0, 0)
var is_moving_left = false
var raycast2d_vertical = null
var raycast2d_Horizontal = null
var attackDetector = null

export(int, 1, 100) var zombie_damage = 20

func _ready():
    animation_enemy = get_node("AnimationPlayer")
    raycast2d_vertical = get_node("RayCast2D_Vertical")
    raycast2d_Horizontal = get_node("RayCast2D_Horizontal")
    attackDetector = get_node("AttackDetector")

func _physics_process(delta):
    if health <= 0:
        enemy_die()

    if animation_enemy.current_animation == "Zombie_Hurt":
        return

    if animation_enemy.current_animation == "Zombie_Die":
        return

    detect_turn_around()
    move_zombie()
    
#Move the zombie around the platform
func move_zombie():
    if animation_enemy.current_animation == "Zombie_Idle":
        return

    if animation_enemy.current_animation == "Zombie_Attack":
        return

    if is_moving_left:
        velocity.x = -speed
        animation_enemy.play("Zombie_Walk")
    else:
        velocity.x = speed
        animation_enemy.play("Zombie_Walk")

    velocity.y += GRAVITY
    velocity = move_and_slide(velocity, Vector2.UP)

#Detect if enemy is colliding with environment, otherwise turn around
func detect_turn_around():
    if not raycast2d_vertical.is_colliding() and is_on_floor() and died == false:
        is_moving_left = !is_moving_left
        #Rotate the enemy to the opposite direction
        scale.x = -scale.x
        animation_enemy.play("Zombie_Idle")
        speed = 0

        yield(get_tree().create_timer(3), "timeout")
        speed = max_speed
        animation_enemy.play("Zombie_Walk")
        
    if raycast2d_Horizontal.is_colliding() and is_on_floor() and died == false:
        is_moving_left = !is_moving_left
        #Rotate the enemy to the opposite direction
        scale.x = -scale.x
        animation_enemy.play("Zombie_Idle")
        speed = 0

        yield(get_tree().create_timer(3), "timeout")
        speed = max_speed
        animation_enemy.play("Zombie_Walk")

#TODO:IF DETECT PLAYER, CHASE PLAYER (UP TO A CERTAIN RANGE)
#...The range area is the same as the limit area

#When player is in range, attack player
func _on_PlayerDetector_body_entered(body: KinematicBody2D):
    if body.collision_layer == 1 and died == false:
        print(self.name, ": Player Detected!")
        speed = 0
        animation_enemy.play("Zombie_Attack")

#When the zombie hit the player...
func _on_AttackDetector_body_entered(body: KinematicBody2D):
    if body.collision_layer == 1 and died == false:
        print(self.name, ": Attack Hit player!")
        body.take_damage(zombie_damage)
        print(body.name, " Health: ", body.health, "/", body.max_health)

func _on_PlayerDetector_body_exited(body: KinematicBody2D):
    if body.collision_layer == 1 and died == false:
        yield(get_tree().create_timer(0.5), "timeout")
        speed = max_speed
        animation_enemy.play("Zombie_Walk")

#When the zombie receive damage
func _on_HurtDetector_body_entered(body):
    if body.collision_layer == 1 and died == false:
        print(self.name, " got hurt! Health: ", self.health, "/", self.max_health)
        animation_enemy.play("Zombie_Hurt")
        speed = 0

        yield(animation_enemy, "animation_finished")
        speed = max_speed
        animation_enemy.play("Zombie_Walk")

func enemy_die():
    animation_enemy.play("Zombie_Die")
    died = true
    yield(animation_enemy, "animation_finished")
    queue_free()
        
#Initial state when attacking
func hit():
    attackDetector.monitoring = true
    
#End state when attacking
func end_hit():
    attackDetector.monitoring = false




