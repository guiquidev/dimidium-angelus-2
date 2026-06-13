extends Action
class_name BasicAttackAction


func execute(origin: Entity, target: Entity):
	var damage: int = data.base_strength
	damage += get_total_buff_strength(origin, Enums.BuffType.DAMAGE)
	
	var action_target: Enums.ActionTarget = data.action_target
	if should_target_self(action_target):
		origin.take_damage(damage)
	
	if should_target_other(action_target):
		target.take_damage(damage)
