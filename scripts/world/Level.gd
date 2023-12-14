extends Node3D

@onready var pause_menu = $PauseMenu
@onready var player = $Player
@onready var race_interactable = $Interactables/RaceInteractable

@onready var engine_force = $GUI/Info/engine_force
@onready var max_steer = $GUI/Info/max_steer
@onready var steer = $GUI/Info/steer
@onready var brake = $GUI/Info/brake
@onready var speed = $GUI/Info/speed

# Called when the node enters the scene tree for the first time.
func _ready():
	race_interactable.race_start.connect(_on_race_start)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	engine_force.text = "engine_force: %s" % [player.engine_force]
	max_steer.text = "max_steer: %s" % [player.max_steer]
	steer.text = "steer: %s" % [player.steering]
	brake.text = "brake: %s" % [player.brake]
	speed.text = "speed: %s" % [snapped(player.linear_velocity.length(), 0.001)]

func _on_race_start():
	print("RACE_STARTED")
	# HIDE INTERACTABLES
	
	# 
