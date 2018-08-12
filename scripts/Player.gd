extends KinematicBody2D

const UP = Vector2(0,-1)
export var speed = 380
export var motion = Vector2()
export var jump_height = -1000
export var gravity = 2400
export var max_fall_speed = 4000
export var stop_min_velocity = 5
export var max_bounces = 4
export var slope_angle = 1.308996939

var state = "idle"


func _physics_process(delta):
	fall(delta)
	run()
	jump()
	check_state()
	motion = move_and_slide(motion,UP,stop_min_velocity,max_bounces,slope_angle) # extra arguments for better scaling slopes
	set_animation()

func check_state():
	if !is_on_floor():
		if motion.y > 100:
			state = "fall"
		elif motion.y < 0:
			state = "jump"
	else: 
		if motion.x == 0.0:
			state = "idle"
		else:
			state = "run"

func set_animation():
	if state == "run":
		$AnimatedSprite.animation = "run"
	elif state == "jump":
		$AnimatedSprite.animation = "jump"
	elif state == "fall":
		$AnimatedSprite.animation = "fall"
	elif state == "idle":
		$AnimatedSprite.animation = "idle"

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		motion.y += gravity * delta
		clamp(motion.y, -jump_height*10, max_fall_speed)

func run(): 
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = speed
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -speed
		$AnimatedSprite.flip_h = true
	else:
		motion.x = 0

func jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = jump_height
			$AudioStreamPlayer.play()
	


func _on_ghost_timer_timeout():
	#if motion.x >= 0.0 or motion.y >= 0.0:
	var ghost = preload("res://scenes/ghost.tscn").instance()
	get_parent().add_child(ghost)
	ghost.position = position
	ghost.scale = $AnimatedSprite.scale
	ghost.flip_h = $AnimatedSprite.flip_h
	ghost.texture = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation,$AnimatedSprite.frame)


func _on_boot_area_area_entered(area):
	motion.y = jump_height
	$AudioStreamPlayer.play()
	
