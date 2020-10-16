extends KinematicBody2D

var speed  = 100
var velocity = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	
	velocity.x = speed * -1
	var motion = velocity * delta
	move_and_collide(motion)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
