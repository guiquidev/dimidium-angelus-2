extends Action
class_name BasicAttackAction


func execute(origin: Entity, target: Entity, action_target: Enums.ActionTarget, strength: int):
	if action_target == Enums.ActionTarget.SELF or action_target == Enums.ActionTarget.BOTH:
		origin.take_damage(strength)
	
	if action_target == Enums.ActionTarget.OTHER or action_target == Enums.ActionTarget.BOTH:
		target.take_damage(strength)
