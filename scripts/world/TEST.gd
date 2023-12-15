extends Node3D

@onready var player = $Player

func _ready():
	# SIGNALS
	player.race_start.connect(_on_race_start)
	
	# MOUSE_MODE
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	pass

func _on_race_start():
	print("RACE START")
