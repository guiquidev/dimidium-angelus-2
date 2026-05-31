extends Resource
class_name Action


func execute(origin: Entity, target: Entity, action_target: Enums.ActionTarget, strength: int):
	print("Action not implemented")
	print("ActionTargetType: ", action_target)
	print("Origin: ", origin.data.name)
	print("Target: ", target.data.name)
	print("Strength: ", strength)
