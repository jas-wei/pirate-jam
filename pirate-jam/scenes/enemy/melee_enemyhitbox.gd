class_name mehitbox
extends Area2D

@export var damage := 2

func _init() -> void:
	collision_layer = 1
	collision_mask = 0
	
