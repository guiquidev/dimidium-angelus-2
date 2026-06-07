extends Room
class_name CombatRoom

@export var player: Player
@export var enemy: Enemy
@export var enemy_data: EntityData

@export var end_turn_button: Button

@export var action_resolver: ActionResolver

var is_player_turn: bool = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func set_enemy():
	enemy.data = enemy_data
	enemy.initialize()


func enter():
	set_enemy()
	enemy.visible = true
	is_player_turn = true
	end_turn_button.visible = true


func execute_action(action_data: ActionData, is_origin_player: bool):
	print("Is player turn? ", is_player_turn)
	if not is_player_turn and is_origin_player:
		print("Not your turn, buddy")
		return
	
	if is_origin_player:
		action_resolver.resolve_action(action_data, player as Entity, enemy as Entity)
	else:
		action_resolver.resolve_action(action_data, enemy as Entity, player as Entity)
	
	if not player.is_alive:
		print("Game over")
		return
		
	if not enemy.is_alive:
		print("Room cleared yay!")
		enemy.visible = false
		end_turn_button.visible = false
		finish()
		return
	
	is_player_turn = not is_player_turn
	
	if not is_player_turn:
		enemy.execute_next_action()


func entity_died(is_player: bool):
	pass
