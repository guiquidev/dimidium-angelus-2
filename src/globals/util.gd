extends Node


func get_cumulative_weights(weights: Array[int]) -> Array[int]:
	var cumulative_weights: Array[int] = []
	for weight in weights:
		if cumulative_weights.size() == 0:
			cumulative_weights.append(weight)
		else:
			cumulative_weights.append(cumulative_weights.back() + weight)
	
	return cumulative_weights


func get_random_weigthed_index(cumulative_weights: Array[int], rng: RandomNumberGenerator = RandomNumberGenerator.new()) -> int:
	var max_cumulative_weight: int = cumulative_weights.back()
	var random_weight: int = rng.randi_range(0, max_cumulative_weight)
	
	for i: int in range(cumulative_weights.size()):
		if cumulative_weights[i] >= random_weight:
			return i
	
	return 0


func get_random_weighted_index_list(weights: Array[int], list_size: int):
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var cumulative_weights: Array[int] = get_cumulative_weights(weights)
	
	var index_list: Array[int] = []
	for i in range(list_size):
		index_list.append(get_random_weigthed_index(cumulative_weights, rng))
	
	return index_list


func compare_buff(buff: BuffStats, reference: BuffStats, ignore: BuffStats) -> bool:
	var compare_type: bool = reference.buff_type == Enums.BuffType.ANY \
		or reference.buff_type == buff.buff_type
	var compare_duration: bool = reference.buff_type == Enums.BuffType.ANY \
		or reference.buff_type == buff.buff_type
	var compare_ignore: bool = buff.buff_duration == ignore.buff_duration \
		or reference.buff_type == ignore.buff_type
	
	return compare_type and compare_duration and (not compare_ignore)


func get_combat_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.COMBAT, Enums.BuffType.NONE)


func get_next_turn_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.NEXT_TURN, Enums.BuffType.NONE)


func get_next_hit_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.NEXT_HIT, Enums.BuffType.NONE)


func get_armor_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.ANY, Enums.BuffType.ARMOR)


func get_none_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.NONE, Enums.BuffType.NONE)


func get_any_buff() -> BuffStats:
	return new_buff_stats(Enums.BuffDuration.ANY, Enums.BuffType.ANY)


func new_buff_stats(duration: Enums.BuffDuration, type: Enums.BuffType) -> BuffStats:
	var buff: BuffStats = BuffStats.new()
	buff.buff_duration = duration
	buff.buff_type = type
	
	return buff
