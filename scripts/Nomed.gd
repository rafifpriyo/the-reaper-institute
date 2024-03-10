extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var _walk_sprite = $AnimatedSprite
#var animation_name = 'idle'
#var animation_direction = 'right'

export (int) var speed = 200
export (int) var jump_speed = -600
export (int) var GRAVITY = 1600

const UP = Vector2(0, -1)

var velocity = Vector2()

var opening_mind_eye = false

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('ui_up'):
		#if animation_direction == 'right':
		#	_walk_sprite.play("jump_right")
		#elif animation_direction == 'left':
		#	_walk_sprite.play("jump_left")
		#animation_name = 'jump'
		velocity.y = jump_speed
	#elif is_on_floor() and animation_name == 'jump':
		#animation_name = 'idle'
		#if animation_direction == 'right':
		#	_walk_sprite.play("idle_right")
		#elif animation_direction == 'left':
		#	_walk_sprite.play("idle_left")
	
	if Input.is_action_pressed('ui_right'):
		#if not animation_name == 'jump' and not animation_name == 'crouch':
		#	_walk_sprite.play("walk_right")
		#	animation_name = 'walk_right'
		#elif animation_name == 'jump':
		#	_walk_sprite.play("jump_right")
		#animation_direction = 'right'
		$Sprite.flip_h = false
		velocity.x += speed
	#elif animation_name == 'walk_right':
	#	animation_name = 'idle'
	#	_walk_sprite.play('idle_right')
	
	if Input.is_action_pressed('ui_left'):
		#if not animation_name == 'jump' and not animation_name == 'crouch':
		#	_walk_sprite.play("walk_left")
		#	animation_name = 'walk_left'
		#elif animation_name == 'jump':
		#	_walk_sprite.play("jump_left")
		#animation_direction = 'left'
		$Sprite.flip_h = true
		velocity.x -= speed
	#elif animation_name == 'walk_left':
	#	animation_name = 'idle'
	#	_walk_sprite.play('idle_left')
	
func basic_animation(velocity):
	if velocity.y < 0:
		$AnimationPlayer.play("Jump")
	elif velocity.x != 0 and is_on_floor():
		$AnimationPlayer.play("Walk")
	elif not opening_mind_eye:
		$AnimationPlayer.play("Idle")

func check_eye(velocity):
	if Input.is_action_pressed("eye_open") and velocity.x == 0 and velocity.y >= 0 and is_on_floor():
		if not opening_mind_eye:
			$EyeTimer.start()
			$AnimationPlayer.play("EyesOpen")
			opening_mind_eye = true
	
	if Input.is_action_just_released("eye_open") or (opening_mind_eye and (velocity.x != 0 or velocity.y < 0)):
		$EyeTimer.stop()
		$AnimationPlayer.stop()
		opening_mind_eye = false
		
		if not self.get_parent().visible:
			SceneManager.shutting_mind_eye_world()
		
func _on_EyeTimer_timeout():
	var path_to_mind_eye_world = self.get_parent().mind_eye_world
	SceneManager.goto_mind_eye_world(str("res://scenes/levels/" + path_to_mind_eye_world + ".tscn"))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity.y  += delta * GRAVITY
	get_input()
	basic_animation(velocity)
	check_eye(velocity)
	velocity = move_and_slide(velocity, UP)
