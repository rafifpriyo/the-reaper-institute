extends Area2D

var bgm_index = 0
var bgms = ["KnockKnock", "Laugh", "Round", "Shu", "Sleep", "Soothe"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Start")
	$LongTimer.start()

func _on_LongTimer_timeout():
	$AnimationPlayer.play("Long")
	_random_bgm()
	
func _random_bgm():
	bgm_index = SceneManager.rng.randi_range(0, bgms.size() - 1)
	var bgm_name = bgms[bgm_index]
	$AudioStreamPlayer.stream = load("res://assets/Self/SFX/" + bgm_name + ".wav")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(2.5), "timeout")
	$AudioStreamPlayer.stop()
	yield(get_tree().create_timer(0.5), "timeout")
	_random_bgm()
