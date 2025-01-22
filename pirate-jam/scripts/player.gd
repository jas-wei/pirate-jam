extends CharacterBody2D
class_name Player

signal healthChanged

@export var speed: float = 250.0

# Gets default gravity value from project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO

signal facingDirectionChanged(facing_right: bool)

@export var maxHealth = 30
@export var attacking = false

@onready var currentHealth = 0
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine

func _ready():
	animation_tree.active = true
	healthChanged.emit()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/acceleration
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && stateMachine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func attack():
	attacking = true
	#animation.play("Attack")
	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)

		
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		
	emit_signal("facingDirectionChanged", !sprite.flip_h)
