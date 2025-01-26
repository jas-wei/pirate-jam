extends Area2D

@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var player: CharacterBody2D = $"../player"

#func _on_ready() -> void:
	#print("timer 2 started")
	#timer.start()

func _on_body_entered(body: Node2D) -> void:
	print("You fell of the map! You piece of sh*t loser!")
	timer.start()
	
func you_suck() -> void:
	if player.currentHealth == 0:
		print("You lost all of your health! You piece of sh*t loser!")
		timer.start()

func _on_timer_timeout() -> void:
	print("Now you get to meet death, you piece of sh*t loser!")
	get_tree().change_scene_to_file("res://scenes/menus/death_screen.tscn")

#func _on_timer_2_timeout() -> void:
	#player.currentHealth -= 10
