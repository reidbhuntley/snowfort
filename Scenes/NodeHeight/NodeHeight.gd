class_name NodeHeight
extends Node

# Add this node as a child of a Node2D and use it to set/get height and 
# depth coordinates of its parent

export var height_coord = 0.0 setget set_height_coord
export var thickness = 1.0

onready var parent = get_parent()

var global_coords: Vector3 setget set_global_coords, get_global_coords
var depth_coord: float setget set_depth_coord, get_depth_coord

func _ready():
	if not (parent is Node2D):
		queue_free()

func set_global_coords(new_global_position_h: Vector3):
	height_coord = new_global_position_h.z
	parent.global_position = Vector2(
		new_global_position_h.x, 
		new_global_position_h.y - height_coord
	)

func get_global_coords() -> Vector3:
	return Vector3(
		parent.global_position.x,
		parent.global_position.y + height_coord,
		height_coord
	)

func set_height_coord(new_height_coord: float):
	parent.global_position.y += height_coord - new_height_coord
	height_coord = new_height_coord

func set_depth_coord(new_depth_coord: float):
	parent.global_position.y = new_depth_coord - height_coord

func get_depth_coord() -> float:
	return parent.global_position.y + height_coord

func depth_overlaps(other) -> bool:
	var depth = get_depth_coord()
	var depth_other = other.get_depth_coord()
	var half_thick = 0.5*thickness
	var half_thick_other = 0.5*other.thickness
	return (
		depth - half_thick <= depth_other + half_thick_other
	) and (
		depth + half_thick >= depth_other - half_thick_other
	)
