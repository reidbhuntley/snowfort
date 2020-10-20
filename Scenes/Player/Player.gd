extends KinematicBody2D

const SPEED = 200
var velocity = Vector2.ZERO

var screen_size
var snowballs = 10

onready var BULLET_SCENE = preload("res://Scenes/Bullet/Bullet.tscn")
const BULLET_HEIGHT = 50

func _ready():
	screen_size = get_viewport_rect().size

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
	if Input.is_action_just_pressed("space"):
		snowballs = snowballs + 1
	
	if Input.is_action_just_pressed("ui_mouse_left"):
		if snowballs > 0:
			fire()
			snowballs = snowballs - 1

func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position() + (Vector2.UP * BULLET_HEIGHT)
	get_parent().add_child(bullet)
	
