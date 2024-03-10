extends Area2D

export var move_to_scene:String
export var is_right_screen: bool = true 
var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	is_ready = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MoveSceneHorizontal_body_entered(body):
	if body.get_name() == "Nomed" and is_ready:
		var nomed_translate = 1275
		print(is_right_screen)
		if is_right_screen:
			nomed_translate = -1 * nomed_translate
		SceneManager.goto_scene(str("res://scenes/levels/" + move_to_scene + ".tscn"), Vector2(nomed_translate, 0))
