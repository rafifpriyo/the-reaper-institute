extends Area2D

export var next_scene: String = "Level1"
var nomed
var is_nomad_here = false

func _ready():
	nomed = self.get_parent().get_node("Nomed")

func _input(event):
	if event.is_action_pressed('ui_select') and is_nomad_here:
		nomed = self.get_parent().get_node("Nomed")
		if not nomed.opening_mind_eye:
			$AnimationPlayer.play("opened")

func _next_level():
	SceneManager.next_level(str("res://scenes/levels/" + next_scene + ".tscn"))

func _nomed_enter_door_animation():
	nomed.entering_door = true

func _on_Door_body_entered(body):
	if body.get_name() == "Nomed":
		$AnimationPlayer.play("half_opened")
		is_nomad_here = true


func _on_Door_body_exited(body):
	if body.get_name() == "Nomed":
		$AnimationPlayer.play("idle")
		is_nomad_here = false
