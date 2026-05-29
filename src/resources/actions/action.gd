extends Resource
class_name Action

@export var name: String
@export var type: Enums.ActionType
@export var target: Enums.ActionTarget
@export var strength: int
@export var next_action: Action
@export var icon: Texture2D
