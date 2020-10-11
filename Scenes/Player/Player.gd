extends KinematicBody2D

const SPEED = 200

var velocity = Vector2.ZERO
onready var BULLET_SCENE = preload("res://Scenes/Bullet.tscn")

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

func _process(delta):
	if Input.is_action_just_pressed("ui_mouse_left"):
		fire()

func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position()
	get_parent().add_child(bullet)
	
