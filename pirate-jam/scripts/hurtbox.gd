class_name HurtBox
extends Area2D

signal recieved_damage(damage: int)

#@export var health: Health




func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	 
func _ready() -> void:
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		print("Damage to enemy")
		recieved_damage.emit(hitbox.damage)
		

	#if owner.has_method("take_damage"):
		#owner.take_damage(hitbox.damage)
