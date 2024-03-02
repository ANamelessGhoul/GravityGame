extends KinematicBody

signal looked_up(player)
signal looked_down(player)

enum States {
	IDLE,
	RUN,
	JUMP,
	FALL
}

export var camera_look_angle: float = 85
export var mouse_look_sensitivity: float = 0.1
export var controller_look_sensitivity: float = 2.5

export var walk_speed: float = 10
export var snap_scale: float = 1
export var jump_force: float = 20

onready var camera_pivot: Spatial = $CameraPivot
onready var camera: Camera = $CameraPivot/Camera

var is_looking_up: bool = false
var is_looking_down: bool = false

var velocity: Vector3

var input_move_vector: Vector2
var input_look_vector: Vector2
var input_should_jump: bool = false

func _process(delta):
	# TODO: Remove and place in a more general area
	if Input.is_action_just_pressed("mouse_escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	###############
	
	input_move_vector = Input.get_vector("left", "right", "forward", "back")
	input_look_vector = Input.get_vector("look_right", "look_left", "look_down", "look_up")
	
	# TODO: Implement coyote time and jump buffering
	input_should_jump = Input.is_action_just_pressed("jump")
	
	rotate_camera(input_look_vector * controller_look_sensitivity)

func _physics_process(delta: float):
	
	var gravity: Vector3 = Physics.get_gravity()
	velocity += gravity * delta * 0.5
	
	
	var gravity_component = velocity.project(gravity)
	var move_vector := Vector3(input_move_vector.x, 0, input_move_vector.y) * walk_speed
	velocity = transform.basis.z * move_vector.z + transform.basis.x * move_vector.x
	velocity += gravity_component
	
	# TODO: Implement coyote time and jump buffering
	if is_on_floor() and input_should_jump:
		velocity += Physics.get_gravity_direction() * -1 * jump_force
	
	
	var snap := Physics.get_gravity_direction() * snap_scale if is_on_floor() else Vector3.ZERO
	var up := Physics.get_gravity_direction() * -1
	velocity = move_and_slide_with_snap(velocity, snap, up, true)

	velocity += gravity * delta * 0.5
	
	input_move_vector = Vector2.ZERO


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_camera(Vector2(-event.relative.x, -event.relative.y) * mouse_look_sensitivity)


func rotate_camera(degrees: Vector2):
	rotate(transform.basis.y, deg2rad(degrees.x))
	
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x + degrees.y, 90 + camera_look_angle * -1, 90 + camera_look_angle)
	
	if camera.rotation_degrees.x > 90 + 80:
		if not is_looking_up:
			emit_signal("looked_up", self)
			is_looking_up = true
	else:
		is_looking_up = false
	
	if camera.rotation_degrees.x < 90 - 80:
		if not is_looking_down:
			emit_signal("looked_down", self)
			is_looking_down = true
	else:
		is_looking_down = false

