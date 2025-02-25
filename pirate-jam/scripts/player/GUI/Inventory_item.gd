class_name InventoryItem
extends TextureRect

@export var data: ItemData


func _ready() -> void:
	if data:
		expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture = data.item_texture
		#tooltip_text = "%s\n%s\nStats: %s Damage, %s Defense" % [data.item_damage, data.item_defense]
		
func _init(d: ItemData = null):
	if d != null:
		data = d

	
func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview(at_position))
	return self
	
func make_drag_preview(at_position: Vector2) -> Control:
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	var c := Control.new()
	c.add_child(t)
	
	return c
