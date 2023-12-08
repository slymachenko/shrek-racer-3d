extends VehicleBody3D

const MAX_STEER_NORMAL = 0.8
const MAX_STEER_NITRO = 0.1
const ENGINE_POWER_NORMAL = 300
const ENGINE_POWER_NITRO = 400

@onready var camera_pivot = $CameraPivot
@onready var front_camera = $CameraPivot/FrontSpringArm/FrontCamera
@onready var reverse_camera = $CameraPivot/ReverseSpringArm/ReverseCamera

var max_steer = MAX_STEER_NORMAL
var engine_power = ENGINE_POWER_NORMAL

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("right", "left") * max_steer, delta * 2.5)
	engine_force = Input.get_axis("backward", "forward") * engine_power 
	
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)

func _input(event):
	# LOOK BACK
	if event.is_action_pressed("look_back"):
		reverse_camera.current = true
	if event.is_action_released("look_back"):
		front_camera.current = true
	# NITRO
	if event.is_action_pressed("nitro"):
		max_steer = MAX_STEER_NITRO
		engine_power = ENGINE_POWER_NITRO
	if event.is_action_released("nitro"):
		max_steer = MAX_STEER_NORMAL
		engine_power = ENGINE_POWER_NORMAL
