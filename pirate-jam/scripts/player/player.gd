extends CharacterBody2D

signal healthChanged

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var maxHealth = 30
@onready var currentHealth = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	healthChanged.emit()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if (Input.is_action_pressed("jump") or Input.is_action_pressed("up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#movements
	if Input.is_action_pressed("left"):
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run")
		velocity.x = -SPEED
	elif Input.is_action_pressed("right"):
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run")
		velocity.x = SPEED
	else:
		animated_sprite_2d.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if !is_on_floor():
		animated_sprite_2d.play("jump")

	move_and_slide()
