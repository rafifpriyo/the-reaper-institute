extends Area2D

export var move_to_scene:String
export var is_lower_screen: bool = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# There's some kind of bug to travel vertically. Like multiple travel at one time. 3 Actually
func _on_MoveSceneVertical_body_entered(body):
	if body.get_name() == "Nomed":
		var nomed_translate = 490
		if is_lower_screen:
			nomed_translate = -1 * nomed_translate
		SceneManager.goto_scene(str("res://scenes/levels/" + move_to_scene + ".tscn"), Vector2(0, nomed_translate))
