extends Node2D
class_name Entity

@export var sprite: Sprite2D
@export var name_label: Label
@export var data: EntityData


func _ready() -> void:
	pass # Replace with function body.


func set_entity_data(_data: EntityData):
	data = _data
	sprite.texture = data.sprite
	sprite.offset.y = -sprite.texture.get_height() / 2
	name_label.text = data.name
