extends EnemyState

@onready var collision: CollisionShape2D = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")

#decalre player_entered flag varibale and make it a setter func
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)
		
func transition():
	if player_entered:
		#if player entered detection area, transition to follow state
		get_parent().change_state("Follow")


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name=="player":
		player_entered = true
		print("no")
