extends KinematicBody2D

var speed  = 100
var direction = Vector2(-1,0)

func _ready():
	pass
	
func _physics_process(delta):
	position += delta*speed*direction
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
