extends Hitbox

var initial_speed := 400.0
var velocity: Vector3
var grav := Vector3(0.0, 0.0, -250.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var vel2d = get_local_mouse_position().normalized()*initial_speed
	velocity = Vector3(vel2d.x, 0.0, -vel2d.y)

func _physics_process(delta):
	velocity += grav*delta
	node_height.global_coords += velocity*delta
	if node_height.height_coord < 0.0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
