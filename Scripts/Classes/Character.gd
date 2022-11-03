extends KinematicBody2D
class_name Character

# Health
export var health = 100
export var max_health = 100

# States
var died = false

# Physics Motion
const GRAVITY = 200
export var speed = 100
var motion = Vector2.ZERO

func recover_health(amount: int) -> void:
    """ Heal the Character by the amount 
    :param amount: Amount to heal Character by
    """
    health += amount

    if health > max_health:
        health = max_health

func take_damage(amount: int) -> void:
    """ Take damage from an attack 
    :param amount: Amount of damage to take
    """
    died = reduce_health(amount)

func reduce_health(amount: int) -> bool:
    """ Reduce health by amount 
    :param amount: Amount to reduce health by
    :return died: Boolean of whether the enemy died or not
    """
    health -= amount

    if health <= 0:
        return true

    return false