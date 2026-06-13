extends Action
class_name BasicBuffAction


func execute(origin: Entity, target: Entity):
	var buff_data: BuffData = self.data as BuffData
	var action_target: Enums.ActionTarget = data.action_target
	if should_target_self(action_target):
		buff_entity(origin, buff_data.buff_stats, buff_data.base_strength)
	
	if should_target_other(action_target):
		buff_entity(target, buff_data.buff_stats, buff_data.base_strength)
