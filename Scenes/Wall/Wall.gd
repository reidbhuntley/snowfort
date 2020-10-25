extends StaticBody2D

func prep_wall():
	if($CellMarker != null):
		$CellMarker.position_wall()


func _on_Hitbox_hitbox_entered(projectile):
	projectile.queue_free()
