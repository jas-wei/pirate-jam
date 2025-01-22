extends Node

class_name CharacterStateMachine

@export var currentState: State
@export var character: CharacterBody2D
@export var animation_tree: AnimationTree

var states: Array[State]

func _ready() -> void:
	for child in get_children():
		if (child is State):
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")
			
func _physics_process(delta: float) -> void:
	if(currentState.nextState != null):
		switch_state(currentState.nextState)
		
	currentState.state_process(delta)

func check_if_can_move():
	return currentState.can_move

func switch_state(new_state: State):
	if (currentState != null):
		currentState.on_exit()
		currentState.nextState = null
	
	currentState = new_state
	
	currentState.on_enter()
	
func _input(event: InputEvent) -> void:
	currentState.state_input(event)
