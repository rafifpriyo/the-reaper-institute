extends Area2D

export var move_to_scene:String
export var is_right_screen: bool = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MoveSceneHorizontal_body_entered(body):
	if body.get_name() == "Nomed":
		var nomed_translate = 930
		if is_right_screen:
			nomed_translate = -1 * nomed_translate
		SceneManager.goto_scene(str("res://scenes/levels/" + move_to_scene + ".tscn"), Vector2(nomed_translate, 0))
