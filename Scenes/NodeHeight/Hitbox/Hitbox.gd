class_name Hitbox
extends Area2D

signal hitbox_entered(area)

export(NodePath) var node_height_path
onready var node_height = get_node(node_height_path)

func _on_Hitbox_area_entered(area):
	if node_height is NodeHeight:
		var node_height_other = area.get("node_height")
		if (
			not node_height_other is NodeHeight
			or node_height.depth_overlaps(node_height_other)
		):
			emit_signal("hitbox_entered", area)
