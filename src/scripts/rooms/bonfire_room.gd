extends Room
class_name BonfireRoom

@export var bonfire_ui: Control
@export var player: Player

var has_healed_player: bool = false


func enter():
	print("Bonfire room entered")
	bonfire_ui.visible = true
	
	entered.emit()
	finish()


func exit():
	print("Bonfire room exited")
	bonfire_ui.visible = false
	exited.emit()


func _on_button_pressed() -> void:
	if has_healed_player:
		print("Already healed")
		return
	
	print("Healing player")
	player.heal(5)
	has_healed_player = true
