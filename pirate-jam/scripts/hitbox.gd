class_name HitBox
extends Area2D

@export var damage: int = 10
@export var player: Player
@export var facing_shape: FacingCollisionShape2D

func _ready():
	monitoring = false
	player.connect("facingDirectionChanged", _on_player_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	for child in (body.get_children()):
		if child is Damageable:
			child.hit(damage)
	
	print(body.name)
	
func _on_player_facing_direction_changed(facing_right: bool):
	if(facing_right):
		facing_shape.position = facing_shape.facing_right_postion
	else:
		facing_shape.position = facing_shape.facing_left_postion
