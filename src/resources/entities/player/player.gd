extends Entity
class_name Player

signal action_added(action: ActionData)
signal action_executed(action: ActionData, is_player: bool)

var current_mana: int = 0


func _ready() -> void:
	initialize()
	add_initial_actions()


func _process(delta: float) -> void:
	pass


func add_action(action_data: ActionData):
	data.actions.append(action_data)
	action_added.emit(action_data)


func add_initial_actions():
	for action_data in data.actions_data:
		action_added.emit(action_data)


func on_action_executed(index: int):
	print("Executing action: ", data.actions_data[index].name)
	action_executed.emit(data.actions_data[index], true)
	
