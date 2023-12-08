extends Node3D

@onready var pause_menu = $PauseMenu
@onready var player = $Player

@onready var engine_force = $GUI/Info/engine_force
@onready var max_steer = $GUI/Info/max_steer

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	engine_force.text = "engine_force: %s" % [player.engine_force]
	max_steer.text = "max_steer: %s" % [player.max_steer]
