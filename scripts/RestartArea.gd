extends Area2D


export (String) var nomed_path = "Nomed"
var nomed
var global_position_start


# Called when the node enters the scene tree for the first time.
func _ready():
	nomed = get_parent().get_node("Nomed")
	global_position_start = nomed.global_position


func _on_RestartArea_body_entered(body):
	if body.get_name() == "Nomed":
		SceneManager.restart_level(global_position_start, str("res://scenes/" + nomed_path + ".tscn"))
