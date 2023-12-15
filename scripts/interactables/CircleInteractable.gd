extends Node3D

signal player_entered
signal player_exited

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player_entered.emit()

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		player_exited.emit()
