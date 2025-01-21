extends Control

func _on_play_pressed() -> void: #this works but camera is wrong
	get_tree().change_scene_to_file("res://scenes/level1.1.tscn")

func _on_build_your_homo_pressed() -> void:
	pass # Replace with function body.
	
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
