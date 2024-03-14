extends Control

export var move_to_scene: String = "Level1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed('ui_select'):
		SceneManager.next_level(str("res://scenes/levels/" + move_to_scene + ".tscn"))
