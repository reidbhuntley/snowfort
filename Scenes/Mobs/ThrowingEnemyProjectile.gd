extends Hitbox

var speed := 400.0


func _process(delta):
	var velocity = Vector2(-1,0)
	velocity *= speed
	position += velocity * delta



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
