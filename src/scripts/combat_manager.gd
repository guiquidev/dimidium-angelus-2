extends Node2D
class_name CombatManager

@export var player: Player
@export var enemy_entity: Enemy
@export var enemy_data: EntityData


func _ready() -> void:
	enemy_entity.set_entity_data(enemy_data)
	execute_action(player.data.actions[0], true)


func _process(delta: float) -> void:
	pass


func execute_action(action: Action, is_origin_player: bool):
	match action.type:
		Enums.ActionType.ATTACK:
			print("attack")
		Enums.ActionType.SKILL:
			print("skill")
		Enums.ActionType.BUFF:
			print("buff")
	
	if action.next_action != null:
		execute_action(action.next_action, is_origin_player)
