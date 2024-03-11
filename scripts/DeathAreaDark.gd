extends Area2D

export (String) var nomed_path = "Nomed"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_DeathArea_body_entered(body):
	if body.get_name() == "Nomed":
		body.death_name = "Dark"


func _on_DeathArea_body_exited(body):
	if body.get_name() == "Nomed":
		body.death_name = "None"
