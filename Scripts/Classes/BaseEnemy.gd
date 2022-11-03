extends Character

#Attach References
export onready var animation_enemy

#Object References
var area2d = Area2D.new()

#Enemies Property
export var layer = 0
export var mask = 0
export var is_layer_on = false
export var is_mask_on = false

func set_layer() -> void:
    #Change the enemy layer
    area2d.set_collision_layer_bit(layer, is_layer_on)

func set_mask() -> void:
    # Change the enemy mask
    area2d.set_collision_mask_bit(mask, is_mask_on)

