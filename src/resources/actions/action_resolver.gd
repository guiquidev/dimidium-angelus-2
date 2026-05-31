extends Node
class_name ActionResolver


func resolve_action(action_data: ActionData, origin: Entity, target: Entity):
	match action_data.type:
		Enums.ActionType.ATTACK:
			pass
		Enums.ActionType.SKILL:
			pass
		Enums.ActionType.BUFF:
			pass
	
	action_data.action.execute(origin, target, action_data.action_target, action_data.strength)
	
	if action_data.next_action != null:
		resolve_action(action_data.next_action, origin, target)
