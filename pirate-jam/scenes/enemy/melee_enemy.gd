extends Node2D


# Called when the node enters the scene tree for the first time.
const SPEED=40
var direction = 1

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castleft: RayCast2D = $RayCastleft
@onready var ray_castdown: RayCast2D = $RayCastdown
@onready var ray_castdown_2: RayCast2D = $RayCastdown2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass
	
func take_damage(amount:int)->void:
	print("enemy damaged")
	
func _process(delta: float) -> void:
	if ray_castright.is_colliding():
		direction=-1
		animated_sprite_2d.flip_h=true
		
	if ray_castleft.is_colliding():
		direction=1
		animated_sprite_2d.flip_h=false
		
	if ray_castdown.is_colliding()==false:
		direction=-1
		animated_sprite_2d.flip_h=true
	
	if ray_castdown_2.is_colliding()==false:
		direction=1
		animated_sprite_2d.flip_h=false
		
	position.x+= direction * SPEED * delta
	

	
