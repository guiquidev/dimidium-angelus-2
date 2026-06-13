extends Node
class_name AudioManager

@export var audio_by_type: Dictionary[Enums.SoundEffect, AudioStream]


func play_sound(sound: Enums.SoundEffect):
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = audio_by_type[sound]
	add_child(player)
	
	player.play()
	await player.finished
	player.queue_free()
