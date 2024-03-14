extends Area2D

export var next_scene: String = "Level1"
var nomed
var is_nomad_here = false

func _ready():
	nomed = self.get_parent().get_node("Nomed")
	$AnimationPlayer.play("idle")
	

func _input(event):
	if event.is_action_pressed('ui_select') and is_nomad_here:
		nomed = self.get_parent().get_node("Nomed")
		_next_level()

func _next_level():
	SceneManager.next_level(str("res://scenes/stories/" + next_scene + ".tscn"))

func _on_Sam_body_entered(body):
	if body.get_name() == "Nomed":
		is_nomad_here = true


func _on_Sam_body_exited(body):
	if body.get_name() == "Nomed":
		is_nomad_here = false
