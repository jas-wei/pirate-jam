extends Node
@onready var player: CharacterBody2D = $"../player"

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	$CanvasLayer/TextureProgressBar.value = player.currentHealth  * 100 / player.maxHealth
