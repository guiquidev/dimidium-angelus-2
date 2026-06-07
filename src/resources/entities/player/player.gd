extends Entity
class_name Player

signal action_added(action: ActionData)

var current_mana: int = 0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func setup():
	initialize()
	add_initial_actions()
	change_health(0, false)


func add_action(action_data: ActionData):
	data.actions.append(action_data)
	action_added.emit(action_data)


func add_initial_actions():
	for action_data in data.actions_data:
		action_added.emit(action_data)


func on_action_button_pressed(index: int):
	print("Player - executing action: ", data.actions_data[index].name)
	action_executed.emit(data.actions_data[index], true)


func hover():
	print("hover")
