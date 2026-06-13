extends Node2D
class_name Entity

signal health_changed(current_health: int, max_health: int, took_damage: bool)
signal action_executed(action: Action, is_player: bool)
signal buff_changed()

@export var sprite: Sprite2D
@export var name_label: Label
@export var data: EntityData

var is_alive: bool = false


func _ready() -> void:
	pass # Replace with function body.


func set_visuals():
	sprite.texture = data.sprite
	sprite.offset.y = -sprite.texture.get_height()
	sprite.offset.y /= 2
	name_label.text = data.name


func initialize():
	data.stats.current_health = data.stats.max_health
	is_alive = true
	set_visuals()
	change_health(0)


func setup():
	pass


func clamp_health():
	var clamped_health: int = max(0, min(data.stats.current_health, data.stats.max_health))
	data.stats.current_health = clamped_health


func change_health(amount: int):
	data.stats.current_health += amount
	
	clamp_health()
	health_changed.emit(data.stats.current_health, data.stats.max_health, amount < 0)
	if data.stats.current_health == 0:
		print("Entity died: ", data.name)
		is_alive = false


func get_total_buff(type: Enums.BuffType):
	var amount: int = 0
	for buff: BuffStats in data.stats.buffs.keys():
		if buff.buff_type == type:
			amount += data.stats.buffs[buff]
	
	return amount


func take_damage(damage: int):
	var armor: int = get_total_buff(Enums.BuffType.ARMOR)
	
	var armor_buffs: BuffStats = Util.get_armor_buff()
	if damage - armor > 0:
		damage -= armor
		change_health(-damage)
	
	remove_buffs(armor_buffs, Util.get_combat_buff(), damage)
	remove_buffs(Util.get_next_hit_buff(), armor_buffs)


func heal(amount: int):
	change_health(amount)


func remove_buffs(reference: BuffStats, ignore: BuffStats, amount: int = 0):
	var amount_left: int = amount
	for buff in data.stats.buffs.keys():
		if not Util.compare_buff(buff, reference, ignore):
			continue
		
		if amount == 0:
			data.stats.buffs[buff] = 0
		else:
			var buff_value: int = data.stats.buffs[buff]
			data.stats.buffs[buff] = max(0, data.stats.buffs[buff] - amount_left)
			amount_left -= buff_value
			if amount_left < 0:
				break
	
	buff_changed.emit()

func add_buff(buff: BuffStats, strength: int):
	var buffs = data.stats.buffs
	if data.stats.buffs.has(buff):
		data.stats.buffs[buff] += strength
	else:
		data.stats.buffs.set(buff, strength)
	
	buff_changed.emit()


func next_turn():
	remove_buffs(Util.get_next_turn_buff(), Util.get_none_buff())
	remove_buffs(Util.get_armor_buff(), Util.get_combat_buff())


func end_turn():
	next_turn()
