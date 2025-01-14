extends Node2D
const SPEED=40
var direction = 1

@onready var ray_cast_right: RayCast2D = $"RayCast right"
@onready var ray_cast_left: RayCast2D = $"RayCast left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction=-1
		animated_sprite_2d.flip_h=true
		
	if ray_cast_left.is_colliding():
		direction=1
		animated_sprite_2d.flip_h=false
		
	position.x+= direction * SPEED * delta
	
	
func take_damage(amount: int) -> void:
	print("enemy -1")
	
