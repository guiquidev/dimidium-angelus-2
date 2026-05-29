extends Entity
class_name Player

@export var base_action_button: PackedScene
@export var actions_container: BoxContainer

var action_button_index = 0


func _ready() -> void:
	add_initial_actions()


func _process(delta: float) -> void:
	pass


func add_action_button(action: Action):
	var new_button: ActionButton = base_action_button.instantiate()
	new_button.text = action.name
	new_button.action_index = action_button_index
	new_button.execute.connect(execute_action)
	action_button_index += 1
	
	actions_container.add_child(new_button)


func add_action(action: Action):
	data.actions.append(action)
	add_action_button(action)


func add_initial_actions():
	for action in data.actions:
		add_action_button(action)


func execute_action(index: int):
	print("Executing action: ", data.actions[index].name)
	
