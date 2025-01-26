
### Hair.gd

extends Node2D

# Node ref
@onready var elemet_sprite = $Sprite2D

# Keys
var element_keys = []
var current_hair_index = 0

func _ready():
	set_sprite_keys()
	update_sprite()
	
# Set keys
func set_sprite_keys():
	element_keys = Global.element.keys() #custom should be a global file. I need to figure out how to do that

# Updates texture & modulate
func update_sprite():
	var current_sprite = element_keys[current_hair_index]	
	
	Global.selected_hair = current_sprite
