class_name YZSort
extends Node2D

class ChildDepth:
	var child: Node
	var depth: float
	func _init(child_: Node, depth_: float):
		child = child_
		depth = depth_
	static func sort(a, b):
		return a.depth < b.depth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var to_sort = []
	for child in get_children():
		if child is Node2D:
			var depth: float
			var node_height = child.get_node("NodeHeight")
			if node_height is NodeHeight:
				depth = node_height.depth_coord
			else:
				depth = child.global_position.y
			to_sort.append(ChildDepth.new(child, depth))
	
	to_sort.sort_custom(ChildDepth, "sort")
	
	for i in to_sort.size():
		to_sort[i].child.z_index = i
