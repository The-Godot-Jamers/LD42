extends KinematicBody2D

const UP = Vector2(0,-1)
export var speed = 50
export var motion = Vector2()
export var jump_height = -1000
export var gravity = 2400
export var max_fall_speed = 4000
export var stop_min_velocity = 5
export var max_bounces = 4
export var slope_angle = 1.308996939

var start = true

func _physics_process(delta):
	fall(delta)
	run()
	motion = move_and_slide(motion,UP,stop_min_velocity,max_bounces,slope_angle) # extra arguments for better scaling slopes

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		motion.y += gravity * delta
		clamp(motion.y, -jump_height*10, max_fall_speed)

func run(): 
	if start:
		if is_on_floor():
			if $AnimatedSprite.flip_h:
				motion.x = -speed
			else:
				motion.x = speed
	else:
		motion.x = 0
	
	var flip = false
	if $AnimatedSprite/down.is_colliding():
		pass
	else:
		flip = true
	if $AnimatedSprite/forward.is_colliding():
		flip = true
	if flip:
		$AnimatedSprite/down.position = -$AnimatedSprite/down.position
		$AnimatedSprite/forward.position = -$AnimatedSprite/forward.position
		$AnimatedSprite/forward.rotation = -$AnimatedSprite/forward.rotation
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _on_top_hit_body_entered(body):
	queue_free()

func _on_Timer_timeout():
	start = !start
