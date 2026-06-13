extends Node
class_name ActionResolver

@export var audio_manager: AudioManager


func resolve_action(action: Action, origin: Entity, target: Entity):
	match action.data.type:
		Enums.ActionType.ATTACK:
			audio_manager.play_sound(Enums.SoundEffect.ATTACK)
		Enums.ActionType.SKILL:
			audio_manager.play_sound(Enums.SoundEffect.SKILL)
		Enums.ActionType.BUFF:
			audio_manager.play_sound(Enums.SoundEffect.BUFF)
	
	action.execute(origin, target)
	
	if not origin.is_alive or not target.is_alive:
		print("An entity died during this action")
		return
	
	if action.next_action != null:
		resolve_action(action.next_action, origin, target)
