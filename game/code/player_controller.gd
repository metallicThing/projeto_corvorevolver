extends CharacterBody3D

const move_speed = 10
const jump_strength = 15
const gravity = 30

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#ACTIONS#
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_strength
		
	move_and_slide()
