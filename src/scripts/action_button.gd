extends Button
class_name ActionButton

signal action_executed(index: int)

var action_index: int = 0


func _on_pressed() -> void:
	action_executed.emit(action_index)
