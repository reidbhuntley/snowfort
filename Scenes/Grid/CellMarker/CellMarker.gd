extends Node2D

export(NodePath) var cell_node
onready var grid = get_node(Grid.GRID_PATH)

func _ready():
	grid.connect("ready", self, "_on_Grid_ready")

func _on_Grid_ready():
	position_wall()

func position_wall():
	var grid_pos = grid.world_to_grid(global_position)
	if(grid.cell_full(grid_pos)):
		get_parent().queue_free()
		return
	
	grid.set_cell(grid_pos, get_node(cell_node))
	get_parent().set_position(grid.grid_to_world_bottom(grid_pos))
	queue_free()
