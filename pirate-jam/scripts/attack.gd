extends State

@export var returnState: State
@export var returnAnimationNode: String = "Move"

@onready var timer: Timer = $Timer

func state_input(event: InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Attack1"):
		if(timer.is_stopped()):
			nextState = returnState
			playback.travel(returnAnimationNode)
		else:
			playback.travel("Attack2")
		
	if(anim_name == "Attack2"):
		if(timer.is_stopped()):
			nextState = returnState
			playback.travel(returnAnimationNode)
		else:
			playback.travel("Attack3")
	
	if(anim_name == "Attack3"):
		nextState = returnState
		playback.travel(returnAnimationNode)
