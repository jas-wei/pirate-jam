extends Label

@export var stateMachine: CharacterStateMachine

func _process(delta: float) -> void:
	text = "State: " + stateMachine.currentState.name
