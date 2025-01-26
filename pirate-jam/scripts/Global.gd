extends Node

# Collection of body sprites
var bodies_collection = {
	"01" : preload("res://assets/character/2d/Idle/T_UE4Robot_IdleStand_D.TGA")
}

# Collection of element
var element = {
	"none" : null,
	"01" : preload("res://assets/character/skills32x32.png"),
	"02" : preload("res://assets/character/skills32x32.png")
	#i need to crop the images...
}

# Collection of attacks, idk what that attacks are yet...
var attacks = {
}

# Skintones
var body_color_options = [
	Color(1, 1, 1), # Default
	Color(0.96, 0.80, 0.69), # Light Skin
	Color(0.72, 0.54, 0.39), # Medium Skin
	Color(0.45, 0.34, 0.27), # Brown Skin
]

# Selected values
var selected_body = ""
var selected_element = ""
var selected_attack = ""
var selected_body_color = ""
var player_name = ""
