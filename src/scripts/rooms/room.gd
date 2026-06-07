extends Node
class_name Room

signal entered()
signal exited()
signal room_finished()

@export var room_type: Enums.RoomType


func enter():
	print("Room entered: ", Enums.RoomType.find_key(room_type))
	entered.emit()
	finish()


func finish():
	print("Room finished: ", Enums.RoomType.find_key(room_type))
	room_finished.emit()


func exit():
	print("Room exited: ", Enums.RoomType.find_key(room_type))
	exited.emit()
