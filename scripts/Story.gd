extends Control

export var move_to_scene: String = "Level1"
export var is_end: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed('ui_select'):
		if is_end:
			SceneManager.next_level(str("res://scenes/stories/" + "ThankYou" + ".tscn"))
		else:
			SceneManager.next_level(str("res://scenes/levels/" + move_to_scene + ".tscn"))
