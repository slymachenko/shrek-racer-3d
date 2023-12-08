extends VehicleBody3D

const MAX_STEER = 0.5
const MAX_STEER_NITRO = 0.1
const ENGINE_POWER = 200
const ENGINE_POWER_NITRO = 400
const MAX_SPEED = 50
const MAX_SPEED_NITRO = 80

@onready var camera_pivot = $CameraPivot
@onready var front_camera = $CameraPivot/FrontSpringArm/FrontCamera
@onready var reverse_camera = $CameraPivot/ReverseSpringArm/ReverseCamera

var max_steer = MAX_STEER
var engine_power = ENGINE_POWER
var acceleration = 0
var max_speed = MAX_SPEED

func _physics_process(delta):
	var velocity = get_linear_velocity()
	var speed = velocity.length()
	if speed > max_speed:
		acceleration = engine_power if engine_power < 0 else 0
	else:
		acceleration = engine_power

	velocity.limit_length(MAX_SPEED_NITRO)

	steering = move_toward(steering, Input.get_axis("right", "left") * max_steer, delta * 2.0 * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))
	engine_force = Input.get_axis("backward", "forward") * acceleration 
	
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
		max_speed = MAX_SPEED_NITRO
	if event.is_action_released("nitro"):
		max_steer = MAX_STEER
		engine_power = ENGINE_POWER
		max_speed = MAX_SPEED
	# BREAKS
	if event.is_action_pressed("brake"):
		brake = 1
	if event.is_action_released("brake"):
		brake = 0
