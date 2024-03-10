extends Area2D

export var next_scene: String = "Level1"

func _input(event):
	if event.is_action_pressed('ui_select'):
		if get_overlapping_bodies().size() > 0:
			SceneManager.next_level(str("res://scenes/levels/" + next_scene + ".tscn"))
