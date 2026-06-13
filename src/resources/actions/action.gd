extends Resource
class_name Action

@export var data: ActionData
@export var next_action: Action


func get_total_buff_strength(entity: Entity, buff_type: Enums.BuffType) -> int:
	return entity.get_total_buff(buff_type)


func buff_entity(entity: Entity, buff: BuffStats, strength: int):
	entity.add_buff(buff, strength)


func should_target_self(action_target: Enums.ActionTarget) -> bool:
	return action_target == Enums.ActionTarget.SELF or action_target == Enums.ActionTarget.BOTH


func should_target_other(action_target: Enums.ActionTarget) -> bool:
	return action_target == Enums.ActionTarget.OTHER or action_target == Enums.ActionTarget.BOTH


func execute(origin: Entity, target: Entity):
	print("Action not implemented")
	print("ActionTargetType: ", data.action_target)
	print("Origin: ", origin.data.name)
	print("Target: ", target.data.name)
	print("Strength: ", data.base_strength)
