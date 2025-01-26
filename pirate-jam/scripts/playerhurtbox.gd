extends Area2D

func _init() -> void:
	collision_layer=0
	collision_mask=1
	
func _ready() -> void:
	connect("body_entered", self._on_body_entered)
	
#change so that its only on area entered for when attack is implemented
#if enemy enter attack range it is damaged
func _on_body_entered(hitbox: mehitbox) -> void:
	if hitbox == null:
		return	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
