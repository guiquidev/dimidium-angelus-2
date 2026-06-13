extends Action
class_name DeathStareAction


func execute(origin: Entity, target: Entity):
	var damage: int = data.base_strength
	
	var action_target: Enums.ActionTarget = data.action_target
	if should_target_self(action_target):
		origin.change_health(-damage)
	
	if should_target_other(action_target):
		target.change_health(-damage)
