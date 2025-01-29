extends EnemyState

@onready var pivot: Node2D = $"../../Pivot"
var can_transition: bool = false

func enter():
	super.enter()
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true
	
func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
	
func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()
	print("yes")

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
