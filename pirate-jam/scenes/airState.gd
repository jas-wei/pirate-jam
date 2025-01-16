extends State

class_name AirState

@export var landing_state: State
@export var double_jump_velocity: float = -200

var has_double_jumped = false

func state_process(delta):
	if (character.is_on_floor()):
		nextState = landing_state
		
func state_input(event: InputEvent):
	if (event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func on_exit():
	if (nextState == landing_state):
		playback.travel("Fall")
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel("Double_Jump")
	has_double_jumped = true
