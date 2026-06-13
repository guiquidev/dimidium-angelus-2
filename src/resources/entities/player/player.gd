extends Entity
class_name Player

signal action_added(action: Action)
signal mana_changed(current_mana: int, max_mana: int)

@export var max_mana: int
@export var mana_gain_per_turn: int

@export var audio_manager: AudioManager

var current_mana: int = 1
var is_in_combat: bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func setup():
	initialize()
	add_initial_actions()


func add_action(action: Action):
	data.actions.append(action)
	action_added.emit(action)


func add_initial_actions():
	for action in data.actions:
		action_added.emit(action)


func change_mana(amount: int):
	current_mana += amount
	mana_changed.emit(current_mana, max_mana)


func enter_combat():
	is_in_combat = true
	change_mana(mana_gain_per_turn)


func end_turn():
	next_turn()
	change_mana(mana_gain_per_turn)


func exit_combat():
	is_in_combat = false
	change_mana(-current_mana)
	remove_buffs(Util.get_any_buff(), Util.get_none_buff())


func on_action_button_pressed(index: int):
	if not is_in_combat:
		print("Not in combat right now")
		return
	
	var action: Action = data.actions[index]
	var action_data: ActionData = action.data
	print("Player - executing action: ", action_data.name)
	
	if action_data.mana_cost > current_mana:
		print("Not enough mana")
		audio_manager.play_sound(Enums.SoundEffect.NOT_ENOUGH_MANA)
		return
	
	change_mana(-action_data.mana_cost)
	action_executed.emit(action, true)
