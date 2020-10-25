extends KinematicBody2D

const BULLET_HEIGHT = 32

var defaultSpeed = 60
var speed  = defaultSpeed
var direction = Vector2(-1,0)
onready var timeBetweenThrows = get_node("TimeBetweenThrows")
onready var timerForThrows = get_node("TimerForThrows")
onready var PROJECTILE_SCENE = preload("res://Scenes/Mobs/ThrowingEnemyProjectile.tscn")

func _ready():
	timeBetweenThrows.start()

func _physics_process(delta):
	move_and_slide(speed*direction)

func _on_Hitbox_hitbox_entered(projectile):
	projectile.queue_free()
	queue_free()

func _on_TimeBetweenThrows_timeout():
	speed = 0
	fire()
	timerForThrows.start()


func _on_TimerForThrows_timeout():
	speed = defaultSpeed
	timeBetweenThrows.start()

func fire():
	var bullet = PROJECTILE_SCENE.instance()
	bullet.position = get_global_position()
	get_parent().add_child(bullet)
	bullet.node_height.height_coord = BULLET_HEIGHT
