extends KinematicBody2D

const SPEED = 200
var velocity = Vector2.ZERO

var screen_size
var snowballs = 10

onready var BULLET_SCENE = preload("res://Scenes/Bullet/Bullet.tscn")
const BULLET_HEIGHT = 50

onready var WALL_SCENE = preload("res://Scenes/Wall/Wall.tscn")
const BUILD_WALL_TIME = 1
var build_wall_progress = 0
onready var progress_bar = $ProgressBar

func _ready():
	screen_size = get_viewport_rect().size
	progress_bar.max_value = BUILD_WALL_TIME
	progress_bar.hide()

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized() # Sets vector to be same length as Vector2.ZERO to Vector2.ONE. Stops diagonal movement from being faster

	if input_vector != Vector2.ZERO:
		velocity = SPEED * input_vector
	else:
		velocity = Vector2.ZERO

	move_and_slide(velocity) # Moves body along input vector. Slides against other objects instead of stopping dead. Accounts for delta automatically.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _process(delta):
	get_node("Label").set_text(str(snowballs))

	if Input.is_action_just_pressed("ui_select"):
		snowballs = snowballs + 1

	if Input.is_action_just_pressed("ui_mouse_left"):
		if snowballs > 0:
			fire()
			#snowballs = snowballs - 1

	if Input.is_action_pressed("build_wall"):
		build_wall_progress += delta
		progress_bar.show()
		progress_bar.value = build_wall_progress
		if(build_wall_progress >= BUILD_WALL_TIME):
			build_wall()
			reset_wall_build()

	if Input.is_action_just_released("build_wall"):
		reset_wall_build()

func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position()
	get_parent().add_child(bullet)
	bullet.node_height.height_coord = BULLET_HEIGHT

func build_wall():
	var wall = WALL_SCENE.instance()
	wall.position = get_global_position()
	get_parent().add_child(wall)
	wall.prep_wall()

func reset_wall_build():
	build_wall_progress = 0;
	progress_bar.hide()
