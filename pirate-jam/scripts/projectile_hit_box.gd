class_name ProjectileHitBox
extends Area2D

@export var damage: int = 10

func _on_body_entered(body: Node2D) -> void:
	for child in (body.get_children()):
		if child is Damageable:
			child.hit(damage)
			get_parent().queue_free()
			
	if body.is_class("TileMap"):
		get_parent().queue_free()
	
	#print(body.name)
