extends Node3D

#constants
const max_loaded_ammo = 6
const max_reserve_ammo = 24

#counters
var loaded_ammo = 5
var reserve_ammo = 18

#state machine
var previous_state = "rest"
var current_state = "rest"
var next_state = "rest"

#flags
var animEnd = false

#objects
@onready var anim = $AnimationPlayer

func _process(delta: float) -> void:
	previous_state = current_state
	current_state = next_state
	if previous_state != current_state:
		print(previous_state, " > ", current_state)
	
	#HANDLING INPUT#
	if Input.is_action_just_pressed("mb1"):
		if loaded_ammo > 0 and current_state == "rest":
			next_state = "fire"
		if current_state == "unready":
			next_state = "hammer"
		if loaded_ammo < 1 and current_state == "rest":
			next_state = "misfire"
	if Input.is_action_just_pressed("r") and loaded_ammo < 6 and reserve_ammo > 0:
		next_state = "reload"
	#HANDLING INPUT#
	
	match current_state:
		"misfire":
			misfire()
		"hammer":
			hammer()
		"fire":
			fire()
		"reload":
			reload()

func rest():
	if previous_state != current_state:
		animEnd = false
		anim.play("Rest")

func hammer():
	if previous_state != current_state:
		animEnd = false
		anim.play("Hammer")
	if animEnd:
		next_state = "rest"
	
func reload():
	if previous_state != current_state:
		animEnd = false
		anim.play("Reload_start")
	if animEnd and loaded_ammo < 6:
		anim.play("Reload_step")
		loaded_ammo += 1
		reserve_ammo -= 1
		animEnd = false
	if animEnd and loaded_ammo == 6:
		anim.play("Reload_end")
		animEnd = false
		next_state = "unready"
		
func misfire():
	if previous_state != current_state:
		anim.play("Misfire")
	
func fire():
	if previous_state != current_state:
		loaded_ammo -= 1
		animEnd = false
		anim.play("Fire")
	if animEnd:
		next_state = "unready"
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animEnd = true
