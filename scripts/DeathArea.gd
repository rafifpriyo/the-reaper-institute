extends Area2D

export (String) var nomed_path = "Nomed"
var nomed
var global_position_start


# Called when the node enters the scene tree for the first time.
func _ready():
	nomed = get_parent().get_node("Nomed")
	global_position_start = nomed.global_position

func _on_DeathArea_body_entered(body):
	if body.get_name() == "Nomed":
		body.death_flag = true


func _on_DeathArea_body_exited(body):
	if body.get_name() == "Nomed":
		body.death_flag = false
