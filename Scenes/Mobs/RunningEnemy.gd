extends KinematicBody2D

var speed  = 60
var direction = Vector2(-1,0)

func _ready():
	pass
	
func _physics_process(delta):
	move_and_slide(speed*direction)

func _on_Hitbox_hitbox_entered(projectile):
	projectile.queue_free()
	queue_free()
