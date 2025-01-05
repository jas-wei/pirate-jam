extends Control

var items_to_load := [
	"res://scenes/player/GUI/Inventory/Resources/shield.tres",
	"res://scenes/player/GUI/Inventory/Resources/sword.tres"
]

func _ready() -> void:
	# Create 24 inventory slots
	for i in range(24):
		var slot = InventorySlot.new()
		slot._init(ItemData.Type.MAIN, Vector2(32, 32))
		%Grid.add_child(slot)

	# Load items and add them to slots
	for i in range(items_to_load.size()):
		var item = InventoryItem.new()
		var item_data = load(items_to_load[i]) as ItemData
		if item_data:
			item._init(item_data)
		else:
			print("Error: Resource is not of type ItemData at index ", i)

		%Grid.get_child(i).add_child(item)
