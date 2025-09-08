extends CharacterBody3D

const move_speed = 10
const jump_strength = 15
const gravity = 30

@onready var camera = $camera_holder

var input_dir
var dir

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#ACTIONS#
	#JUMP#
	if Input.is_action_just_pressed("space") and is_on_floor(): 
		velocity.y = jump_strength
	#DEBUG#
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	#DEBUG#
	
	#MOVE#
	input_dir = Input.get_vector("a", "d", "w", "s")
	dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	
	if dir:
		velocity.x = dir.x * move_speed
		velocity.z = dir.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
		
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * -0.20))
		camera.rotate_x(deg_to_rad(event.relative.y * -0.20))
		if rad_to_deg(camera.rotation.x) > 85: #upper limit
			camera.rotation.x = deg_to_rad(85)
		elif rad_to_deg(camera.rotation.x) < -75: #lower limit
			camera.rotation.x = deg_to_rad(-75)
	
