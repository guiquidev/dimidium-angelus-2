extends Action
class_name DebuffSkillAction


func execute(origin: Entity, target: Entity):
	var buff_data: BuffData = self.data as BuffData
	var action_target: Enums.ActionTarget = data.action_target
	
	if should_target_self(action_target):
		origin.remove_buffs(buff_data.buff_stats, Util.get_none_buff(), buff_data.base_strength)
	
	if should_target_other(action_target):
		target.remove_buffs(buff_data.buff_stats, Util.get_none_buff(), buff_data.base_strength)
