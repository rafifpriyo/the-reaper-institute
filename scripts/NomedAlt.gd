extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$LongTimer.start()

func _on_LongTimer_timeout():
	$AnimationPlayer.play("Long")
