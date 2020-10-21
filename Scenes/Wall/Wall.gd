extends StaticBody2D

func prep_wall():
	if($CellMarker != null):
		$CellMarker.position_wall()
