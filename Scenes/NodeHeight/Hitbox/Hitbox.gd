class_name Hitbox
extends Area2D

signal hitbox_entered(area)

export(NodePath) var node_height_path
onready var node_height = get_node(node_height_path)

var intersecting_nodes = []

func _ready():
	if not (node_height is NodeHeight):
		print("Warning: Hitbox has no valid NodeHeight assigned")
		queue_free()

func _on_Hitbox_area_entered(area):
	var node_height_other = area.get("node_height")
	if node_height_other is NodeHeight:
		intersecting_nodes.append(area)
	else:
		emit_signal("hitbox_entered", area)

func _process(delta):
	for i in range(intersecting_nodes.size() - 1, -1, -1):
		var node = intersecting_nodes[i]
		var node_height_other = node.get("node_height")
		if node_height.depth_overlaps(node_height_other):
			emit_signal("hitbox_entered", node)
			intersecting_nodes.remove(i)

func _on_Hitbox_area_exited(area):
	var idx = intersecting_nodes.find(area)
	if idx >= 0:
		intersecting_nodes.remove(idx)
