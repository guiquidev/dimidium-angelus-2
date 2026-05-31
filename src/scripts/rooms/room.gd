extends Node
class_name Room

signal entered()
signal exited()
signal room_cleared()

@export var room_type: Enums.RoomType


func enter():
	pass


func exit():
	pass
