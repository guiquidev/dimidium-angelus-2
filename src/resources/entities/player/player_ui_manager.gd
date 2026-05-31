extends Node
class_name PlayerUIManager

@export var player: Player

@export var base_action_button: PackedScene
@export var actions_container: GridContainer

@export var health_label: Label
@export var mana_label: Label

var action_button_index = 0


func on_action_added(action_data: ActionData):
	var new_button: ActionButton = base_action_button.instantiate()
	new_button.text = action_data.name
	new_button.action_index = action_button_index
	new_button.action_executed.connect(player.on_action_executed)
	
	actions_container.add_child(new_button)
	
	action_button_index += 1


func on_health_changed(current_health: int, max_health: int, took_damage: bool):
	health_label.text = str(current_health) + " / " + str(max_health)
