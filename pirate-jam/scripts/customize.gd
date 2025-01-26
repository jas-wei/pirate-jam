extends Control

var fight_type = ""
var element = ""
#i think i need to make this file global or something so people can access these variables from anywhere

func _on_melee_pressed() -> void:
	fight_type = "melee"
	
func _on_range_pressed() -> void:
	fight_type = "range"
