extends Node
class_name RoomManager

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


func get_random_room_index(cumulative_weights: Array[int], rng: RandomNumberGenerator) -> int:
	var max_cumulative_weight: int = cumulative_weights.back()
	var random_weight: int = rng.randi_range(0, max_cumulative_weight)
	
	for i: int in range(cumulative_weights.size()):
		if cumulative_weights[i] >= random_weight:
			return i
	
	return 0


func get_cumulative_weights() -> Array[int]:
	var cumulative_weights: Array[int] = []
	for room in rooms_weights.keys():
		var weight: int = rooms_weights[room]
		if cumulative_weights.size() == 0:
			cumulative_weights.append(weight)
		else:
			cumulative_weights.append(cumulative_weights.back() + weight)
	
	return cumulative_weights


func generate_rooms():
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	
	var cumulative_weights: Array[int] = get_cumulative_weights()
	
	for i: int in range(room_count):
		var room_index: int = get_random_room_index(cumulative_weights, rng)
		rooms.append(room_index as Enums.RoomType)
	
	print("Map generated:")
	for room in rooms:
		print("RoomType: ", Enums.RoomType.find_key(room))


func enter_room():
	is_current_room_finished = false
	continue_button.visible = false
	rooms_by_type[rooms[current_room_index]].enter()
	#is_current_room_finished = true


func go_to_next_room():
	if current_room_index >= room_count - 1:
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
