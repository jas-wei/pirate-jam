extends Control



func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/level1.1.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
