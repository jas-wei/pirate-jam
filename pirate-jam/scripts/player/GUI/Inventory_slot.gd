class_name InventorySlot
extends PanelContainer

@export var type : ItemData.Type

func _init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	# Unequipping items:
	if get_child_count() > 0:
		var item := get_child(0)
		#TODO: Player loses item stats
		if item == data:
			return
		item.reparent(item.get_parent())
	# Equipping items:
	if type != ItemData.Type.MAIN:
		#TODO: Player gains item stats
		#REMOVE BELOW FUNCTION ITS COUNTERINTUITIVE AND A PLACEHOLDER
		type = ItemData.Type.MAIN
	data.reparent(self)
