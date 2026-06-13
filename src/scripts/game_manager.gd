extends Node
class_name GameManager

@export var title_screen: CanvasLayer
@export var win_screen: CanvasLayer
@export var lose_screen: CanvasLayer

@export var player: Player
@export var room_manager: RoomManager
@export var transition_manager: TransitionManager


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func start_game():
	await transition_manager.fade_in()
	title_screen.hide()
	player.setup()
	room_manager.initialize()
	await transition_manager.fade_out()


func restart_game():
	await transition_manager.fade_in()
	get_tree().reload_current_scene()


func win_game():
	await transition_manager.fade_in()
	win_screen.show()
	await transition_manager.fade_out()


func lose_game():
	await transition_manager.fade_in()
	lose_screen.show()
	await transition_manager.fade_out()
