extends Control

#@onready var coin = preload("res://scenes/coin.tscn")

var items_to_load := [
	"res://scenes/player/GUI/Inventory/Resources/shield.tres",
	#"res://scenes/player/GUI/Inventory/Resources/sword.tres",
	"res://scenes/player/GUI/Inventory/Resources/coin.tres"
]

func _ready() -> void:
	
	InitSignals()
	
	# Create 24 inventory slots
	for i in range(24):
		var slot = InventorySlot.new()
		slot._init(ItemData.Type.MAIN, Vector2(32, 32))
		%Grid.add_child(slot)
	
	

	#var coin_instance = coin.instantiate()
	#add_child(coin_instance)
#
	## Load items and add them to slots
	#coin_instance.pickup.connect(load_item)
	#load_item(items_to_load)

func InitSignals():
	Signals.connect("pickup", pickup)

func pickup():
	load_item(["res://scenes/GUI/Inventory/Resources/coin.tres"])

func load_item(array):
	for i in range(array.size()):
		var item = InventoryItem.new()
		var item_data = load(array[i]) as ItemData
		if item_data:
			item._init(item_data)
		else:
			print("Error: Resource is not of type ItemData at index ", i)
			
		var grid_index = i
		while %Grid.get_child(grid_index).get_child_count() >0:
			grid_index+=1
		%Grid.get_child(grid_index).add_child(item)
		print("bing!")
