extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_parent().find_child("player")

var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	#make it player homing
	acceleration = (player.position - position).normalized() * 700
	velocity += acceleration * delta
	rotation = velocity.angle() #rotate to point at player
	velocity = velocity.limit_length(150)
	position += velocity * delta #update position

func _on_body_entered(body: Node2D) -> void:
	queue_free()
