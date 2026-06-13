extends CanvasLayer
class_name GameUIManager

@export var root: Node
@export var description_label: Label


func _ready() -> void:
	connect_hoverable_panel(root)


func _process(delta: float) -> void:
	pass


func connect_hoverable_panel(node: Node):
	if node.is_in_group("hoverable") and "hover_description" in node:
		connect_hover_signals(node)
	elif node.get_class() == "Control":
		(node as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var children: Array[Node] = node.get_children(true)
	for child in children:
		connect_hoverable_panel(child)


func connect_hover_signals(node: Node):
	var node_control: Control = node as Control
	node_control.mouse_entered.connect(on_node_hovered_in.bind(node))
	node_control.mouse_exited.connect(on_node_hovered_out)


func get_font_size(text: String) -> int:
	if text.length() > 200:
		return 19
	if text.length() > 150:
		return 23
	if text.length() > 100:
		return 25
	if text.length() > 75:
		return 28
	
	return 30


func on_node_hovered_in(node: Node):
	description_label.text = node.hover_description
	var font_size = get_font_size(node.hover_description)
	description_label.add_theme_font_size_override("font_size", font_size)


func on_node_hovered_out():
	description_label.text = ""
