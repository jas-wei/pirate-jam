extends CharacterBody2D

signal healthChanged

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_attacking = false

@export var maxHealth = 30
@onready var currentHealth = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	healthChanged.emit()

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle attack
	if Input.is_action_just_pressed("mouse_left") and not is_attacking and is_on_floor():
		is_attacking = true
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("sword_attack")
		return

	# Handle jump


	# Handle movement (blocked if attacking)
	if not is_attacking:
		if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("up")) and is_on_floor():
			velocity.y = JUMP_VELOCITY
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

		if not is_on_floor():
			animated_sprite_2d.play("jump")

	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "sword_attack":
		is_attacking = false
