extends EnemyState
var its_ready = false

func _on_transition_timer_timeout():
	transition()

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
	
func exit():
	super.exit()
	owner.set_physics_process(false)
	
func transition():
	var distance = owner.direction.length()
	#print(distance)
	
	if distance >0:
		its_ready = true
	
	if distance < 30 and its_ready == true:
		get_parent().change_state("MeleeAttack")
	elif distance >500:
#		randomly toggle
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissile")
			1:
				get_parent().change_state("LaserBeam")
