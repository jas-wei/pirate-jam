extends Control

var items_to_load := [
	"res://scenes/player/GUI/Inventory/Resources/shield.tres",
	"res://scenes/player/GUI/Inventory/Resources/sword.tres"
]

func _ready() -> void:
	for i in 24:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32))
		%Grid.add_child(slot)
	for i in items_to_load.size:
		var item = InventoryItem.new()
		item.init(load(items_to_load[i]))
		%Grid.get_child(i).add_child(item)
