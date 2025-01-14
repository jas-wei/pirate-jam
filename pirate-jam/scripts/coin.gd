extends Area2D
var inventory

func _on_body_entered(_body: Node2D) -> void:
	print ("entered")
	Signals.emit_signal("pickup")
	self.queue_free()
