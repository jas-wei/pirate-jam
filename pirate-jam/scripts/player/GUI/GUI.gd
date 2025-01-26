extends CanvasLayer

@onready var connect_dots: Control = $Container/connect_dots
@onready var referenced_scene = preload("res://scenes/GUI/connect_dots.tscn")  # PackedScene
var connect_dots_script

func _ready() -> void:
	get_node("Container").hide()
	connect_dots_script = get_tree().get_nodes_in_group("Connect_dots")[0]
	
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		get_node("Container").visible = get_tree().paused
		
		connect_dots_script.dots.clear()
		var children = $Container/connect_dots/line_layer.get_children()
		for child in children:
			child.queue_free()



func _on_inventory_pressed() -> void:
	hideGUI()
	$Container/Panel/VBoxContainer2/Inventory.disabled = true
	$Container/Inventory.show()
	var children = $Container/connect_dots/line_layer.get_children()
	for child in children:
		child.hide()

func _on_spells_pressed() -> void:
	hideGUI()
	$Container/Panel/VBoxContainer2/Spells.disabled = true
	$Container/connect_dots.show()
	var children = $Container/connect_dots/line_layer.get_children()
	for child in children:
		child.show()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func hideGUI():
	$Container/Panel/VBoxContainer2/Spells.disabled = false
	$Container/Panel/VBoxContainer2/Inventory.disabled = false
	$Container/Panel/VBoxContainer2/Main_Menu.disabled = false
	$Container/Inventory.hide()
	$Container/connect_dots.hide()

func _on_coin_pickup() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	hideGUI()
	get_node("Container").hide()
	connect_dots_script = get_tree().get_nodes_in_group("Connect_dots")[0]
	get_tree().paused = false
	
