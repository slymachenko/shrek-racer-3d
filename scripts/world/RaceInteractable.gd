extends Node3D

signal race_start

@onready var hud = $"../../GUI/Hud"

var is_player_entered = false

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		is_player_entered = true
		hud.visible = true

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		is_player_entered = false
		hud.visible = false

func _input(event):
	if event.is_action_pressed("interact") and is_player_entered:
		race_start.emit()
