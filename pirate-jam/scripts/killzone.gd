extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died! You piece of sh*t loser!")
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
	
