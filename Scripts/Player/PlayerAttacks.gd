class_name PlayerAttacks

# Character Attack Properties
var jump_attack_damage = 20

# Character Attack Methods
func handle_jump_attack() -> int:
    """ Perform a jump attack. 
    :param motion: The motion of the character.
    :return: The damage dealt by the attack.
    """
    return jump_attack_damage