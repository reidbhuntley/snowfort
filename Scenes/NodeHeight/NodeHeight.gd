class_name NodeHeight
extends Node

# Add this node as a child of a Node2D and use it to set/get height and 
# depth coordinates of its parent

const SHADOW_BASE_SIZE = Vector2(64.0, 64.0)

export var height_coord = 0.0 setget set_height_coord
export var thickness = 16.0 setget set_thickness
export var show_shadow = true setget set_show_shadow
export var shadow_width = 32.0 setget set_shadow_width

onready var parent = get_parent()
onready var shadow = $Shadow

var global_coords: Vector3 setget set_global_coords, get_global_coords
var depth_coord: float setget set_depth_coord, get_depth_coord

func _ready():
	if not (parent is Node2D):
		queue_free()
	
	set_thickness(thickness)
	set_show_shadow(show_shadow)
	set_shadow_width(shadow_width)

func _process(delta):
	var global_coords = get_global_coords()
	shadow.global_position = Vector2(global_coords.x, global_coords.y)

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

func set_thickness(new_thickness):
	thickness = new_thickness
	if is_inside_tree():
		shadow.scale.y = new_thickness / SHADOW_BASE_SIZE.y

func set_show_shadow(show):
	show_shadow = show
	if is_inside_tree():
		shadow.visible = show

func set_shadow_width(new_width):
	shadow_width = new_width
	if is_inside_tree():
		shadow.scale.x = new_width / SHADOW_BASE_SIZE.x
