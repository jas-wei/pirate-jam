#class_name hurtbox
extends Area2D
 
func _init() -> void:
	collision_layer=0
	collision_mask=2
	
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
#change so that its only on area entered for when attack is implemented
#if enemy enter attack range it is damaged
func _on_area_entered(hitbox) -> void:
	print("asdasd")
	if hitbox == null:
		return	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		
