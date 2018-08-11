extends KinematicBody2D

const UP = Vector2(0,-1)
var speed = 180
var movement = Vector2()
var jump_height = -500




func _physics_process(delta):

	movement.y += 10 
	if Input.is_action_pressed("ui_right"):
		movement.x = speed
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		movement.x = -speed
		$AnimatedSprite.flip_h = false
	else:
		movement.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			movement.y = jump_height
			$AudioStreamPlayer.play()
	movement = move_and_slide(movement,UP)
	