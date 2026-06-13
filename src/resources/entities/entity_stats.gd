extends Resource
class_name EntityStats

@export var max_health: int
@export var buffs: Dictionary[BuffStats, int]

var current_health: int
