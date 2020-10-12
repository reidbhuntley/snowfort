extends Area2D

var speed = 10
var movement = Vector2()
onready var mouse_pos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	movement = movement.move_toward(mouse_pos, delta)
	movement = movement.normalized() * speed
	position = position + movement

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
