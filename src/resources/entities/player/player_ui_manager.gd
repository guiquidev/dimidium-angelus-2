extends Node
class_name PlayerUIManager

@export var player: Player

@export var base_action_button: PackedScene
@export var actions_container: GridContainer
@export var game_ui_manager: GameUIManager

@export var health_progress: TextureProgressBar
@export var health_description_panel: DescriptionPanel

@export var mana_progress: TextureProgressBar
@export var mana_description_panel: DescriptionPanel

var action_button_index = 0


func get_button_hover_description(action: Action) -> String:
	var description: String = action.data.description
	description += "\nStrength: " + str(action.data.base_strength)
	description += "\nCost: " + str(action.data.mana_cost)
	
	return description


func on_action_added(action: Action):
	var action_data = action.data
	var new_button: ActionButton = base_action_button.instantiate()
	new_button.text = action_data.name
	new_button.hover_description = get_button_hover_description(action)
	new_button.action_index = action_button_index
	new_button.action_executed.connect(player.on_action_button_pressed)

	actions_container.add_child(new_button)
	game_ui_manager.connect_hover_signals(new_button)

	action_button_index += 1


func get_value_percentage(value: int, max_value: int) -> float:
	return (float(value) / float(max_value)) * 100


func get_formatted_health_text(health: int, max_health: int) -> String:
	return "What's left of you: " + str(health) + "/" + str(max_health)


func on_health_changed(current_health: int, max_health: int, took_damage: bool):
	health_progress.value = get_value_percentage(current_health, max_health)
	health_description_panel.hover_description = get_formatted_health_text(current_health, max_health)


func get_formatted_mana_text(mana: int, max_mana: int) -> String:
	return "Your magic power: " + str(mana) + "/" + str(max_mana) + \
		"\nYou get some more every turn"


func on_mana_changed(current_mana: int, max_mana: int):
	mana_progress.value = get_value_percentage(current_mana, max_mana)
	mana_description_panel.hover_description = get_formatted_mana_text(current_mana, max_mana)
	
