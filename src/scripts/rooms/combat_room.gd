extends Room
class_name CombatRoom

@export var player: Player
@export var enemy_entity: Enemy
@export var enemy_data: EntityData

@export var action_resolver: ActionResolver


func _ready() -> void:
	enemy_entity.data = enemy_data
	enemy_entity.initialize()


func _process(delta: float) -> void:
	pass


func execute_action(action_data: ActionData, is_origin_player: bool):
	if is_origin_player:
		action_resolver.resolve_action(action_data, player as Entity, enemy_entity as Entity)
	else:
		action_resolver.resolve_action(action_data, enemy_entity as Entity, player as Entity)
