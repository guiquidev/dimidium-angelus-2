extends Camera2D
class_name CameraManager

@export var animation_player: AnimationPlayer


func shake():
	animation_player.play("shake")


func _on_player_health_changed(current_health: int, max_health: int, took_damage: bool) -> void:
	if took_damage:
		shake()
