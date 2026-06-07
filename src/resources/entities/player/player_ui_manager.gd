extends Node
class_name PlayerUIManager

@export var player: Player

@export var base_action_button: PackedScene
@export var actions_container: GridContainer
@export var game_ui_manager: GameUIManager

@export var health_progress: TextureProgressBar
@export var health_description_panel: DescriptionPanel

var action_button_index = 0


func on_action_added(action_data: ActionData):
	var new_button: ActionButton = base_action_button.instantiate()
	new_button.text = action_data.name
	new_button.hover_description = action_data.description
	new_button.action_index = action_button_index
	new_button.action_executed.connect(player.on_action_button_pressed)

	actions_container.add_child(new_button)
	game_ui_manager.connect_hover_signals(new_button)

	action_button_index += 1


func get_health_percentage(health: int, max_health: int) -> float:
	return (float(health) / float(max_health)) * 100


func get_formatted_health_text(health: int, max_health: int) -> String:
	return "What's left of you: " + str(health) + "/" + str(max_health)


func on_health_changed(current_health: int, max_health: int, took_damage: bool):
	health_progress.value = get_health_percentage(current_health, max_health)
	health_description_panel.hover_description = get_formatted_health_text(current_health, max_health)
