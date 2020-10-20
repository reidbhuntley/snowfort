class_name Grid
extends YSort

const GRID_PATH = @"/root/Game/Grid"

const CELL_WIDTH = 64.0
const CELL_HEIGHT = 64.0
const CELL_SIZE = Vector2(CELL_WIDTH, CELL_HEIGHT)

var grid_size = Vector2(16,16)


export var grid_bounds = Vector2.ONE

var grid = []

func _ready():
	for x in range(grid_bounds.x):
		var col = []
		for y in range(grid_bounds.y):
			col.append(null)
		grid.append(col)

func cell_in_bounds(pos: Vector2):
	return pos.x < grid_bounds.x and pos.y < grid_bounds.y

func get_cell(pos: Vector2):
	if cell_in_bounds(pos):
		return grid[pos.x][pos.y]
	else:
		return null

func set_cell(pos: Vector2, value):
	if cell_in_bounds(pos):
		grid[pos.x][pos.y] = value
	else:
		pass
		#print("oof")

func cell_full(pos: Vector2):
	return grid[pos.x][pos.y] != null

func world_to_grid(pos: Vector2):
	return (global_transform.xform_inv(pos) / CELL_SIZE).floor()

func grid_to_world(pos: Vector2):
	return global_transform.xform(pos * CELL_SIZE)

func grid_to_world_centered(pos: Vector2):
	return grid_to_world(pos + Vector2.ONE*0.5)

func _process(delta):
	#print(grid)
	pass
