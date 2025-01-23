extends RigidBody2D

var size
var hitbox_enabled = true

func make_room(_pos, _size):
	position = _pos
	size = _size
	var s = RectangleShape2D.new()
	s.custom_solver_bias = 0.75
	s.extents = size
	$CollisionShape2D.shape = s

	# Lock the CollisionShape2D to the room
	$CollisionShape2D.position = Vector2.ZERO
	$CollisionShape2D.rotation = 0


func toggle_hitbox():
	hitbox_enabled = !hitbox_enabled
	$CollisionShape2D.disabled = !hitbox_enabled
