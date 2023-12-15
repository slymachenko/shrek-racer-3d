extends Control

@onready var interaction = $Interaction

@onready var engine_force = $Info/VBoxContainer/engine_force
@onready var max_steer = $Info/VBoxContainer/max_steer
@onready var steer = $Info/VBoxContainer/steer
@onready var brake = $Info/VBoxContainer/brake
@onready var speed = $Info/VBoxContainer/speed

var player

func _ready():
	var raceInteractable = get_tree().get_root().find_children("RaceInteractable", "Node3D", true, false)[0]
	raceInteractable.player_entered.connect(_on_player_entered)
	raceInteractable.player_exited.connect(_on_player_exited)
	
	player = get_tree().get_root().find_children("Player", "VehicleBody3D", true, false)[0]

func _process(delta):
	engine_force.text = "engine_force: %s" % [player.engine_force]
	max_steer.text = "max_steer: %s" % [player.max_steer]
	steer.text = "steer: %s" % [player.steering]
	brake.text = "brake: %s" % [player.brake]
	speed.text = "speed: %s" % [snapped(player.linear_velocity.length(), 0.001)]

func _on_player_entered():
	interaction.visible = true

func _on_player_exited():
	interaction.visible = false
