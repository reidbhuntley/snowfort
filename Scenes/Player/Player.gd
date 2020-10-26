extends KinematicBody2D

const SPEED = 200
var velocity = Vector2.ZERO

var screen_size
export var snowballs = 10
export var max_health = 100.0
var current_health : float
var frozen = false
const UNFROZEN_STEP = 20
onready var hp_bar = $HPBar

onready var BULLET_SCENE = preload("res://Scenes/Bullet/Bullet.tscn")
const BULLET_HEIGHT = 32
const BUILD_SNOWBALL_TIME = .75
var build_snowball_progress = 0

onready var WALL_SCENE = preload("res://Scenes/Wall/Wall.tscn")
const BUILD_WALL_TIME = 1
var build_wall_progress = 0
onready var progress_bar = $ProgressBar


func _ready():
	screen_size = get_viewport_rect().size
	
	progress_bar.max_value = BUILD_WALL_TIME
	progress_bar.hide()
	
	hp_bar.max_value = max_health
	current_health = max_health
	hp_bar.value = current_health


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	if !frozen:
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized() # Sets vector to be same length as Vector2.ZERO to Vector2.ONE. Stops diagonal movement from being faster

	if input_vector != Vector2.ZERO:
		velocity = SPEED * input_vector
		reset_snowball_build()
		reset_wall_build()
	else:
		velocity = Vector2.ZERO

	move_and_slide(velocity) # Moves body along input vector. Slides against other objects instead of stopping dead. Accounts for delta automatically.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _process(delta):
	get_node("Label").set_text(str(snowballs))


	if frozen:
		current_health += UNFROZEN_STEP * delta
		hp_bar.value = current_health
		if current_health >= max_health:
			current_health = max_health
			frozen = false
	else:
		# Reloading
		if Input.is_action_just_pressed("reload"):
			progress_bar.show()

		if Input.is_action_pressed("reload"):
			build_snowball_progress += delta
			progress_bar.value = build_snowball_progress
			if(build_snowball_progress >= BUILD_SNOWBALL_TIME):
				snowballs = snowballs + 1
				reset_snowball_build()
		
		if Input.is_action_just_released("reload"):
			reset_snowball_build()
			progress_bar.hide()

		# Firing
		if Input.is_action_just_pressed("ui_mouse_left"):
			if snowballs > 0:
				fire()
				snowballs = snowballs - 1

		# Wall building
		if Input.is_action_just_pressed("build_wall"):
			progress_bar.show()

		if Input.is_action_pressed("build_wall"):
			build_wall_progress += delta
			progress_bar.value = build_wall_progress
			if(build_wall_progress >= BUILD_WALL_TIME):
				build_wall()
				reset_wall_build()

		if Input.is_action_just_released("build_wall"):
			reset_wall_build()
			progress_bar.hide()


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


func reset_snowball_build():
	build_snowball_progress = 0;


func _on_Hitbox_hitbox_entered(projectile):
	var damage = projectile.get("damage")
	if (damage is float) and (not frozen):
		current_health -= damage
		hp_bar.value = current_health
		if current_health <= 0.0:
			current_health = 0.0
			frozen = true
	
	projectile.queue_free()
