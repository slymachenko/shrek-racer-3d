extends VehicleBody3D

const MAX_STEER_NORMAL = 0.8
const MAX_STEER_NITRO = 0.1
const ENGINE_POWER_NORMAL = 300
const ENGINE_POWER_NITRO = 400

@onready var camera_pivot = $CameraPivot
@onready var front_camera = $CameraPivot/FrontCamera
@onready var reverse_camera = $CameraPivot/ReverseCamera

var look_at
var max_steer = MAX_STEER_NORMAL
var engine_power = ENGINE_POWER_NORMAL

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	look_at = global_position

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("right", "left") * max_steer, delta * 2.5)
	engine_force = Input.get_axis("backward", "forward") * engine_power 
	
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	look_at = look_at.lerp(global_position + linear_velocity, delta * 5.0)
	front_camera.look_at(look_at)
	reverse_camera.look_at(look_at)
	_check_camera_switch()

func _input(event):
	# NITRO
	if event.is_action_pressed("nitro"):
		max_steer = MAX_STEER_NITRO
		engine_power = ENGINE_POWER_NITRO
	if event.is_action_released("nitro"):
		max_steer = MAX_STEER_NORMAL
		engine_power = ENGINE_POWER_NORMAL

func _check_camera_switch():
	if linear_velocity.dot(transform.basis.z) >= 0:
		front_camera.current = true
	else:
		reverse_camera.current = true
