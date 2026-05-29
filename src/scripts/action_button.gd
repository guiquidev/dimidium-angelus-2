extends Button
class_name ActionButton

signal execute(index: int)

var action_index: int = 0


func _on_pressed() -> void:
	execute.emit(action_index)
