extends Node

var rng

var current_level = null
var current_scene = null
var mind_eye_world = null
var have_changed = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	current_level = current_scene.name
	rng = RandomNumberGenerator.new()
	
func restart_level(nomed_position, nomed_path):
	call_deferred("_deferred_restart_level", nomed_position, nomed_path)
	
func _deferred_restart_level(nomed_position, nomed_path):
	var nomed: KinematicBody2D = current_scene.get_node('Nomed')
	
	# It is now safe to remove the current scene.
	current_scene.remove_child(nomed)
	nomed.queue_free()
	
	# Load the new scene.
	var s = ResourceLoader.load(nomed_path)
	
	var new_nomed = s.instance()
	new_nomed.global_position = nomed_position
	
	current_scene.add_child(new_nomed)
	new_nomed.name = "Nomed"

func death():
	call_deferred("_deferred_death")
	
func _deferred_death():
	current_scene.queue_free()
	
	# Load the new scene.
	var s = ResourceLoader.load("res://scenes/levels/" + current_level + ".tscn")

	# Instance the new scene.
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
func next_level(path):
	
	call_deferred("_deferred_next_level", path)
	
func _deferred_next_level(path):
	current_scene.queue_free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()
	current_level = current_scene.name
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
func goto_scene(path, nomed_translation: Vector2):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	if have_changed:
		return
	else:
		have_changed = true
		call_deferred("_deferred_goto_scene", path, nomed_translation)


func _deferred_goto_scene(path, nomed_translation: Vector2):
	var nomed: KinematicBody2D = current_scene.get_node('Nomed')
	var new_global_position = nomed.global_position + nomed_translation
	print(nomed.global_position)
	have_changed = true
	
	# It is now safe to remove the current scene.
	current_scene.remove_child(nomed)
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()
	if current_scene.has_node('Nomed'):
		# It is more safe to remove the child first before freeing
		# free is immediate, queue free need waiting
		var old_nomad = current_scene.get_node('Nomed')
		current_scene.remove_child(old_nomad)
		old_nomad.free()
	nomed.global_position = new_global_position
	current_scene.add_child(nomed)
	nomed.name = "Nomed"
	
	#current_scene.free()
	#current_scene = next_current_scene

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	have_changed = false
	
func goto_mind_eye_world(path):
	call_deferred("_deferred_goto_mind_eye_world", path)
	
func _deferred_goto_mind_eye_world(path):
	var nomed: KinematicBody2D = current_scene.get_node('Nomed')

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	mind_eye_world = s.instance()
	var nomed_alt = ResourceLoader.load(str("res://scenes/" + "NomedAlt" + ".tscn"))
	var nomed_sprite = nomed_alt.instance()
	nomed_sprite.global_position = nomed.global_position
	nomed_sprite.get_node("Sprite").flip_h = nomed.get_node("Sprite").flip_h
	nomed_sprite.name = "NomedAlt"
	
	mind_eye_world.add_child(nomed_sprite)
	
	current_scene.visible = false

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(mind_eye_world)

func shutting_mind_eye_world():
	call_deferred("_deferred_shutting_mind_eye_world")
	
func _deferred_shutting_mind_eye_world():
	mind_eye_world.get_node("NomedAlt").get_node("AnimationPlayer").stop()
	mind_eye_world.queue_free()
	
	current_scene.visible = true
