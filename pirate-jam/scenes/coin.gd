extends Area2D
var inventory

func _ready() -> void:
	inventory=get_tree().get_nodes_in_group("inventory")[0]

func _on_body_entered(_body: Node2D) -> void:
	print ("entered")
	inventory.load_item(["res://scenes/player/GUI/Inventory/Resources/coin.tres"])
	self.queue_free()
