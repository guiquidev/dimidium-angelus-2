extends Node2D
class_name Entity

signal health_changed(current_health: int, max_health: int, took_damage: bool)
signal action_executed(action: ActionData, is_player: bool)

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


func clamp_health():
	var clamped_health: int = max(0, min(data.stats.current_health, data.stats.max_health))
	data.stats.current_health = clamped_health


func change_health(amount: int, took_damage: bool):
	if took_damage:
		data.stats.current_health -= amount
	else:
		data.stats.current_health += amount
	
	clamp_health()
	health_changed.emit(data.stats.current_health, data.stats.max_health, took_damage)
	if data.stats.current_health == 0:
		print("Entity died: ", data.name)
		is_alive = false


func take_damage(damage: int):
	change_health(damage, true)


func heal(amount: int):
	change_health(amount, false)
