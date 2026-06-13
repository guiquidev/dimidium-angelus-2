extends Action
class_name HealAction


func execute(origin: Entity, target: Entity):
	var heal_amount: int = data.base_strength
	
	var action_target: Enums.ActionTarget = data.action_target
	if should_target_self(action_target):
		origin.heal(heal_amount)
	
	if should_target_other(action_target):
		target.heal(heal_amount)
