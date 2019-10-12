extends RigidBody

const VIEW_SENSITIVITY = 0.25
const SPEED = 20
const PITCH_LIMIT = 85

var yaw = 0		# yaw is left/right (y axis)
var pitch = 0	# pitch is up/down (x axis)
				# roll would be z axis
				
onready var camera = $Camera
				
func _input(event):
	if event is InputEventMouseMotion:
		yaw = fmod(yaw - event.relative.x * VIEW_SENSITIVITY, 360)
		pitch = max(min(pitch - event.relative.y * VIEW_SENSITIVITY, PITCH_LIMIT), -PITCH_LIMIT)
		camera.rotation_degrees = Vector3(pitch, 0, 0)
		rotation_degrees = Vector3(0, yaw, 0)
		
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
		
	if Input.is_action_pressed("move_forwards"):
		var x = sin(deg2rad(-yaw))
		var z = -cos(deg2rad(yaw))
		set_linear_velocity(Vector3(x, 0, z) * SPEED)
	elif Input.is_action_pressed("move_backwards"):
		var x = sin(deg2rad(-yaw) - PI)
		var z = -cos(deg2rad(yaw) - PI)
		set_linear_velocity(Vector3(x, 0, z) * SPEED)
	elif Input.is_action_pressed("move_left"):
		var x = sin(deg2rad(-yaw) - PI/2)
		var z = -cos(deg2rad(yaw) + PI/2)
		set_linear_velocity(Vector3(x, 0, z) * SPEED)
	elif Input.is_action_pressed("move_right"):
		var x = sin(deg2rad(-yaw) + PI/2)
		var z = -cos(deg2rad(yaw) - PI/2)
		set_linear_velocity(Vector3(x, 0, z) * SPEED)
	else:
		set_linear_velocity(Vector3())