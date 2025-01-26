extends Control



func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/level1.1.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_animated_sprite_2d_animation_looped() -> void:
	pass # Replace with function body.


func _on_ready() -> void:
	pass
	#AnimatedSprite2D.play() # Replace with function body.
