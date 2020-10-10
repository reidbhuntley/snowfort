extends Node2D

export(NodePath) var cell_node
onready var grid = get_node(Grid.GRID_PATH)

func _ready():
	grid.connect("ready", self, "_on_Grid_ready")

func _on_Grid_ready():
	grid.set_cell(grid.world_to_grid(global_position), get_node(cell_node))
	queue_free()
