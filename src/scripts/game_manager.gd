extends Node
class_name GameManager

@export var room_manager: RoomManager
@export var player: Player


func _ready() -> void:
	player.setup()
	room_manager.initialize()


func _process(delta: float) -> void:
	pass
