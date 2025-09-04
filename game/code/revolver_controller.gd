extends Node3D

const max_loaded_ammo = 6
const max_reserve_ammo = 24

var loaded_ammo = 6
var reserve_ammo = 18

var previous_state = "unready"
var current_state = "ready"
var next_state

@onready var anim = $AnimationPlayer

func _process(delta: float) -> void:
	previous_state = current_state
	current_state = next_state
	
	#HANDLING INPUT#
	if Input.is_action_just_pressed("mb1"):
		if loaded_ammo > 0 and current_state == "ready":
			next_state = "fire"
		if current_state == "unready":
			next_state = "hammer"
		if loaded_ammo < 1 and current_state == "ready":
			next_state = "misfire"
	if Input.is_action_just_pressed("r") and loaded_ammo < 6 and reserve_ammo > 0:
		next_state = "reload"
	#HANDLING INPUT#
	
	match current_state:
		"ready":
			rest()
		"unready":
			unready()
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
		anim.play("reload_start")

func hammer():
	if previous_state != current_state:
		anim.play("rest")
	
func unready():
	if previous_state != current_state:
		anim.play("rest")
	
func reload():
	if previous_state != current_state:
		anim.play("rest")
	
func misfire():
	if previous_state != current_state:
		anim.play("rest")
	
func fire():
	if previous_state != current_state:
		anim.play("rest")
