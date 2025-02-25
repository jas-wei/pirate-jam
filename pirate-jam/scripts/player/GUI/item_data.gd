class_name ItemData
extends Resource

enum Type {ARMOUR, WEAPON, ACCESSORY, MAIN, COIN}

@export var type : Type
@export var item_name : String
@export var item_damage : int
@export var item_defense : int
@export_multiline var description : String
@export var item_texture : Texture2D
#@export var count: Label
