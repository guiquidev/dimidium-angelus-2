extends Entity
class_name Enemy

@export var description_panel: DescriptionPanel

var current_action_index: int = 0


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func set_description():
	description_panel.hover_description = data.description


func setup():
	initialize()
	set_description()
	current_action_index = 0


func on_turn_ended():
	next_turn()


func choose_next_action():
	current_action_index = (current_action_index + 1) % data.actions.size()


func execute_next_action():
	print("Enemy - executing action: ", data.actions[current_action_index].data.name)
	action_executed.emit(data.actions[current_action_index], false)
	choose_next_action()
