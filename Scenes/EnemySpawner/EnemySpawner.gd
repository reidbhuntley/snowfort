extends Node

onready var grid = get_parent().get_node("Grid")
onready var LASTCOL = grid.grid_bounds.x - 1

onready var MOB_SCENE = preload("res://Scenes/Mobs/RunningEnemy.tscn")

func spawn_mob():
	var mob = MOB_SCENE.instance()
	var randomRow = rand_range(1, grid.grid_bounds.y + 1) as int
	# print("Spawn position is grid(" + LASTCOL as String + ", " + randomRow as String + ")")
	mob.position = grid.grid_to_world_centered(Vector2(LASTCOL, randomRow))

	grid.add_child(mob)
