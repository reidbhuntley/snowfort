extends Area2D

var initial_speed := 500.0
var velocity: Vector2
var grav := Vector2(0.0, 400.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = get_local_mouse_position().normalized()*initial_speed

func _physics_process(delta):
	velocity += grav*delta
	position += velocity*delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
		queue_free()
