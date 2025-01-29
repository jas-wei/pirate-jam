extends CharacterBody2D

@onready var player = get_parent().find_child("player", true)
@onready var sprite = $Sprite2D
@export var speed = 100
@onready var progress_bar: ProgressBar = $UI/ProgressBar

var direction:Vector2
var DEF = 0

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
#			if health < 50% switch to armor buff
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff")

func _ready() -> void:
	#turn off physics process
	set_physics_process(false)
	#print(player)
	
func _process(_delta: float) -> void:
	# face player
	direction = player.position - position
	
	if direction.x<0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta: float) -> void:
#	move towards player
	velocity = direction.normalized() * speed
	move_and_collide(velocity * delta)

func take_damage():
	health -= 10 + DEF
