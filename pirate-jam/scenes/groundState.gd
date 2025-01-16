extends State

class_name GroundState

@export var jump_velocity: float = -400.0
@export var airState: State

func state_process(delta):
	if (!character.is_on_floor()):
		nextState = airState

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	character.velocity.y = jump_velocity
	nextState = airState
	playback.travel("Jump")
