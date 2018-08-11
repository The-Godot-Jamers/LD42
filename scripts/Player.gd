extends KinematicBody2D

const UP = Vector2(0,-1)
export var speed = 380
export var motion = Vector2()
export var jump_height = -1000
export var gravity = 2400




func _physics_process(delta):
	fall(delta)
	run()
	jump()
	motion = move_and_slide(motion,UP,5,4,1.308996939) # extra arguments for better scaling slopes

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		motion.y += gravity * delta

func run(): 
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = speed
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -speed
		$AnimatedSprite.flip_h = false
	else:
		motion.x = 0

func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_height
			$AudioStreamPlayer.play()
	
	