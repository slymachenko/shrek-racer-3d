extends VehicleBody3D

signal race_start

const DRIFT_STEER = 0.4
const MAX_STEER = 0.5
const MAX_STEER_NITRO = 0.5
const ENGINE_POWER = 15000
const ENGINE_POWER_NITRO = 25000
const MAX_SPEED = 20
const MAX_SPEED_NITRO = 50
 
@onready var camera_pivot = $CameraPivot
@onready var front_camera = $CameraPivot/FrontSpringArm/FrontCamera
@onready var reverse_camera = $CameraPivot/ReverseSpringArm/ReverseCamera
@onready var back_left = $BackLeft
@onready var back_right = $BackRight

var max_steer = MAX_STEER
var engine_power = ENGINE_POWER
var acceleration = 0
var max_speed = MAX_SPEED

var is_entered_race = false

var drift_force = 5000
var max_drift_angle = 45

func _ready():
	var raceInteractable = get_tree().get_root().find_children("RaceInteractable", "Node3D", true, false)[0]
	raceInteractable.player_entered.connect(_on_player_entered_race)
	raceInteractable.player_exited.connect(_on_player_exited_race)

func _physics_process(delta):
	var velocity = get_linear_velocity()
	var speed = velocity.length()
	
	if speed > max_speed and Input.get_axis("backward", "forward") > 0:
		acceleration = 0
	else:
		acceleration = engine_power

	velocity.limit_length(MAX_SPEED_NITRO)
	
	steering = move_toward(steering, Input.get_axis("right", "left") * max_steer, delta * 2.0 * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))
	engine_force = Input.get_axis("backward", "forward") * acceleration
	
	camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5.0)
	
	var handbrake = Input.is_action_pressed("brake")
	
	if abs(steering) > DRIFT_STEER:
		apply_torque(Vector3(0, Input.get_axis("right", "left") * drift_force * 2, 0))
	else:
		apply_torque(Vector3(0, Input.get_axis("right", "left") * engine_force / 5, 0))
	if abs(steering) > DRIFT_STEER:
		var current_speed = linear_velocity.length()
		var drift_angle = abs(angular_velocity.y) * current_speed / drift_force
		# Cap the drift angle
		drift_angle = min(max_drift_angle, drift_angle)
		# Apply additional lateral force for drifting
		var drift_force_vector = Vector3(0, drift_angle * drift_force, 0)
		apply_torque(drift_force_vector)
		
		back_left.steering = move_toward(back_right.steering, -steering / max_steer * 0.1, delta * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))
		back_right.steering = move_toward(back_right.steering, -steering / max_steer * 0.1, delta * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))
	else:
		back_left.steering = move_toward(back_right.steering, 0, delta * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))
		back_right.steering = move_toward(back_right.steering, 0, delta * (1.5 - (clamp(speed, 0, max_speed)/max_speed)))

func _input(event):
	# LOOK BACK
	if event.is_action_pressed("look_back"):
		reverse_camera.current = true
	if event.is_action_released("look_back"):
		front_camera.current = true
	# NITRO
	if event.is_action_pressed("nitro") and Input.get_axis("backward", "forward") > 0:
		max_steer = MAX_STEER_NITRO
		engine_power = ENGINE_POWER_NITRO
		max_speed = MAX_SPEED_NITRO
	if event.is_action_released("nitro") or Input.get_axis("backward", "forward") < 0:
		max_steer = MAX_STEER
		engine_power = ENGINE_POWER
		max_speed = MAX_SPEED
	# BREAKS
	if event.is_action_pressed("brake"):
		brake = 225
	if event.is_action_released("brake"):
		brake = 0
	# INTERACT
	if event.is_action_pressed("interact"):
		if is_entered_race:
			race_start.emit()

func _on_player_entered_race():
	is_entered_race = true

func _on_player_exited_race():
	is_entered_race = false
