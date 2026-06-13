extends TextureRect
class_name EntityStatsDisplay

@export var entity: Entity
@export var hover_description: String
@export var buffs_to_display: Array[Enums.BuffType]
@export var buff_display_name: Dictionary[Enums.BuffType, String]


func update_description():
	var new_description: String = "- Current Stats -\n"
	
	var health: int = entity.data.stats.current_health
	new_description += "Health: " + str(health)
	
	for buff_type: Enums.BuffType in buffs_to_display:
		var buff_amount: int = entity.get_total_buff(buff_type)
		if buff_amount == 0:
			continue
		
		new_description += "\n"
		new_description += buff_display_name[buff_type]
		new_description += ": " + str(buff_amount)
	
	hover_description = new_description


func on_entity_health_changed(current_health: int, max_health: int, took_damage: bool):
	update_description()


func on_entity_buff_changed():
	update_description()
