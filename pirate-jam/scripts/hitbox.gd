class_name HitBox
extends Area2D

@export var damage: int = 10 : set = set_damage, get = get_damage

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

func set_damage(value: int):
	damage = value
	
func get_damage() -> int:
	return damage
