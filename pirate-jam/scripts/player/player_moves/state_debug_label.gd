extends Label

@export var stateMachine: CharacterStateMachine

func _process(_delta: float) -> void:
	text = "State: " + stateMachine.currentState.name
