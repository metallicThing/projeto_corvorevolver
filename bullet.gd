extends Area3D

@onready var origin = get_tree().get_nodes_in_group("bullet_exit")

func _ready() -> void:
	position = origin.position
	rotation = origin.rotation
	
func _process(delta: float) -> void:
	pass
