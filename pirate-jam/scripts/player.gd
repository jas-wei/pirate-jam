extends CharacterBody2D

signal healthChanged

@export var speed: float = 250.0
@export var jump_velocity: float = -350.0
@export var double_jump_velocity: float = -200

# Gets default gravity value from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jump: bool = false
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var was_in_air: bool = false

@export var maxHealth = 30
@export var attacking = false

@onready var currentHealth = 0
@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

func _ready():
	healthChanged.emit()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jump = false
		
		if was_in_air == true:
			land()

		was_in_air = false
		
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump from floor
			jump()
		elif not has_double_jump:
			# Double jump in air 
			velocity.y += double_jump_velocity
			has_double_jump = true
	
	
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && animation.current_animation != "fall":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	update_animation()
	move_and_slide()
	update_facing_direction()

func attack():
	#var overlapping_object = $Sprite2D/HitBox.get_overlapping_areas()
	#
	#for area in overlapping_object:
		#var parent = area.get_parent()
		#print(parent.name)
	
	attacking = true
	animation.play("Attack")
	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
			
			
			
	#if !attacking:
		#if velocity.x != 0:
			#animation.play("Run")
		#else:
			#animation.play("Idle")
		#
		#if velocity.y < 0:
			#animation.play("Jump")
		#if velocity.y > 0:
			#animation.play("Fall")
		
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func jump():
	velocity.y = jump_velocity
	animation.play("Jump")
	animation_locked = true
	
func land():
	animation.play("Fall")
	animation_locked = true

func _on_animation_player_animation_finished():
	if(animation.current_animation == "Fall"):
		animation_locked = false
