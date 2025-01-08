extends CanvasLayer



func _ready() -> void:
	get_node("Container").hide()
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		get_node("Container").visible = get_tree().paused


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
	hideGUI()

func hideGUI():
	$Container/Panel/VBoxContainer2/Spells.disabled = false
	$Container/Panel/VBoxContainer2/Inventory.disabled = false
	$Container/Panel/VBoxContainer2/Main_Menu.disabled = false
	$Container/Inventory.hide()
	$Container/connect_dots.hide()
	
