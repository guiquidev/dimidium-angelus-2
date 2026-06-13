extends Room
class_name BonfireRoom

@export var bonfire_ui: Control
@export var player: Player
@export var heal_button: Button
@export var heal_amount: int

var has_healed_player: bool = false


func enter():
	print("Bonfire room entered")
	bonfire_ui.visible = true
	heal_button.disabled = false
	
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
	player.heal(heal_amount)
	heal_button.disabled = true
	has_healed_player = true
