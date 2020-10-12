class_name Grid
extends YSort

const GRID_PATH = @"/root/Game/Grid"

const CELL_WIDTH = 64.0
const CELL_HEIGHT = 64.0
const CELL_SIZE = Vector2(CELL_WIDTH, CELL_HEIGHT)

export var grid_bounds = Vector2.ONE

var grid = []

func _ready():
	for x in range(grid_bounds.x):
		var col = []
		for y in range(grid_bounds.y):
			col.append(null)
		grid.append(col)

func get_cell(pos: Vector2):
	return grid[pos.x][pos.y]

func set_cell(pos: Vector2, value):
	grid[pos.x][pos.y] = value

func world_to_grid(pos: Vector2):
	return (global_transform.xform_inv(pos) / CELL_SIZE).floor()

func grid_to_world(pos: Vector2):
	return global_transform.xform(pos * CELL_SIZE)

func grid_to_world_centered(pos: Vector2):
	return grid_to_world(pos + Vector2.ONE*0.5)

func _process(delta):
	#print(grid)
	pass
