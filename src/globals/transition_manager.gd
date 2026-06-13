extends CanvasLayer
class_name TransitionManager

@export var screen_cover: ColorRect
@export var fade_in_duration: float
@export var fade_out_duration: float

@export var fade_in_color: Color
@export var fade_out_color: Color

var tween: Tween


func _ready() -> void:
	fade_out()


func fade_in():
	screen_cover.show()
	reset_tween()
	tween.tween_property(screen_cover, "modulate", fade_in_color, fade_in_duration)
	await tween.finished


func fade_out():
	reset_tween()
	tween.tween_property(screen_cover, "modulate", fade_out_color, fade_out_duration)
	await tween.finished
	screen_cover.hide()


func reset_tween():
	if tween:
		tween.kill()
	
	tween = create_tween()
