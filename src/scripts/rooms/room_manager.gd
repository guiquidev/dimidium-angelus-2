extends Node
class_name RoomManager

signal rooms_cleared()

@export var room_count: int
@export var rooms_by_type: Dictionary[Enums.RoomType, Room]
@export var rooms_weights: Dictionary[Enums.RoomType, int]

@export var continue_button: Button

var current_room_index: int = 0
var rooms: Array[Enums.RoomType] = []
var is_current_room_finished: bool = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func initialize():
	generate_rooms()
	connect_room_signals()
	enter_room()


func connect_room_signals():
	for room: Room in rooms_by_type.values():
		room.room_finished.connect(on_room_finished)


func generate_rooms():
	rooms.append(Enums.RoomType.COMBAT)
	rooms.append(Enums.RoomType.COMBAT)
	rooms.append(Enums.RoomType.BONFIRE)
	rooms.append(Enums.RoomType.COMBAT)
	rooms.append(Enums.RoomType.COMBAT)
	return
	
	# Room generation
	var index_list = Util.get_random_weighted_index_list(rooms_weights.values(), room_count)
	for index in index_list:
		rooms.append(index as Enums.RoomType)
	
	print("Map generated:")
	for room in rooms:
		print("RoomType: ", Enums.RoomType.find_key(room))


func enter_room():
	is_current_room_finished = false
	continue_button.visible = false
	rooms_by_type[rooms[current_room_index]].enter()


func go_to_next_room():
	if current_room_index >= room_count - 1:
		rooms_cleared.emit()
		print("Reached the end")
		return
	
	print("Exiting ", Enums.RoomType.find_key(rooms[current_room_index]))
	rooms_by_type[rooms[current_room_index]].exit()
	
	current_room_index += 1
	print("Entering ", Enums.RoomType.find_key(rooms[current_room_index]))
	
	enter_room()


func on_room_finished():
	is_current_room_finished = true
	continue_button.visible = true


func _on_continue_button_pressed() -> void:
	if not is_current_room_finished:
		print("Room not finished")
		return
	
	go_to_next_room()
