extends "res://Scripts/Classes/BaseEnemy.gd"

var velocity = Vector2(0, 0)
var raycast2d = null
var is_moving_left = true

func _ready():
    #TODO:Play Animation
    #FIXME: EMPTY
    raycast2d = get_node("RayCast2D")

func _physics_process(delta):
    move_zombie()
    detect_turn_around()
    
#Move the zombie around the platform
func move_zombie():
    if is_moving_left:
        velocity.x = -speed
    else:
        velocity.x = speed

    velocity.y += GRAVITY
    velocity = move_and_slide(velocity, Vector2.UP)

#Detect if enemy is colliding with environment, otherwise turn around
func detect_turn_around():
    if not raycast2d.is_colliding() and is_on_floor():
        is_moving_left = !is_moving_left
        #Rotate the enemy to the opposite direction
        scale.x = -scale.x
        
#TODO:IF DETECT PLAYER, CHASE PLAYER (UP TO A CERTAIN RANGE)
#...The range area is the same as the limit area

#TODO:IF PLAYER IS IN RANGE, ATTACK PLAYER







