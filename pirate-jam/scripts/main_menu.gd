extends Control

func _on_play_pressed() -> void: #this works but camera is wrong
	get_tree().change_scene_to_file("res://scenes/level1.1.tscn")

func _on_build_your_homo_pressed() -> void:
	pass
	#get_tree().change_scene_to_file("res://scenes/customize_homo.tscn")
	#this doesnt really work cuz of Null or something... i think its cuz the customize isnt really a finished scene
	
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/settings.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
