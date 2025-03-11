class_name HitBox
extends Area2D

@export var damage := 10

func _ready():
	# Set collision layers and masks (moved from _init to _ready)
	collision_layer = 0
	collision_mask = 2

	# Connect the body_entered signal
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Check if the entering body is the boss
	if body.is_in_group("boss"):  # Ensure the boss is in the "boss" group
		print("-10")
