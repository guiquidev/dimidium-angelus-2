extends Room
class_name CombatRoom

signal turn_ended()
signal player_died()

@export var background: Sprite2D
@export var background_textures: Array[Texture2D]

@export var player: Player
@export var enemy: Enemy
@export var enemy_data: Array[EntityData]
@export var enemy_turn_timer: Timer

@export var end_turn_button: Button

@export var action_resolver: ActionResolver

var is_player_turn: bool = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func set_enemy():
	var index: int = RandomNumberGenerator.new().randi_range(0, enemy_data.size() - 1)
	enemy.data = enemy_data[index]
	enemy.setup()


func choose_random_background():
	var random_index: int = RandomNumberGenerator.new().randi_range(0, background_textures.size() - 1)
	background.texture = background_textures[random_index]
	background.visible = true


func enter():
	choose_random_background()
	set_enemy()
	enemy.visible = true
	is_player_turn = true
	player.enter_combat()
	end_turn_button.show()


func exit():
	background.visible = false
	exited.emit()


func execute_action(action: Action, is_origin_player: bool):
	print("Is player turn? ", is_player_turn)
	if not is_player_turn and is_origin_player:
		print("Not your turn, buddy")
		return
	
	if is_origin_player:
		action_resolver.resolve_action(action, player as Entity, enemy as Entity)
	else:
		end_turn_button.hide()
		enemy_turn_timer.start()
		await enemy_turn_timer.timeout
		action_resolver.resolve_action(action, enemy as Entity, player as Entity)
		end_turn_button.show()
		player.end_turn()
	
	if not player.is_alive:
		player_died.emit()
		print("Game over")
		return
	
	if not enemy.is_alive:
		print("Room cleared yay!")
		enemy.visible = false
		end_turn_button.hide()
		player.exit_combat()
		finish()
		return


func next_turn():
	is_player_turn = true


func _on_end_turn_button_pressed() -> void:
	is_player_turn = false
	
	enemy.end_turn()
	enemy.execute_next_action()
	
	turn_ended.emit()
	next_turn()


func entity_died(is_player: bool):
	pass
