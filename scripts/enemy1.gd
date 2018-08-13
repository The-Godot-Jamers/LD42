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

var game = preload("res://scenes/game_thrown.tscn")

var start = true


func _ready():
	add_to_group("enemies")
	$Timer.wait_time += rand_range(0.1, 0.5)

func _physics_process(delta):
	if $death_timer.is_stopped():
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
		$AnimatedSprite.animation = "walk"
		if is_on_floor():
			if $AnimatedSprite.flip_h:
				motion.x = speed
			else:
				motion.x = -speed
	else:
		$AnimatedSprite.animation = "idle"
		motion.x = 0
	
	var flip = false
	if $AnimatedSprite/down.is_colliding():
		pass
	else:
		flip = true
	if $AnimatedSprite/forward.is_colliding() or $AnimatedSprite/forward2.is_colliding():
		flip = true
	if flip:
		$AnimatedSprite/down.position = -$AnimatedSprite/down.position
		$AnimatedSprite/forward.position = -$AnimatedSprite/forward.position
		$AnimatedSprite/forward.rotation = -$AnimatedSprite/forward.rotation
		$AnimatedSprite/forward2.position = -$AnimatedSprite/forward2.position
		$AnimatedSprite/forward2.rotation = -$AnimatedSprite/forward2.rotation
		$thow_area.rotation_degrees -= 180
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

	
func _on_Timer_timeout():
	start = !start

func throw_rubbish():
	if $throw_timer.is_stopped():
		$AnimatedSprite.animation = "throw"
		var thrown = game.instance()
		thrown.position = position
		$throw_timer.start()
		if $AnimatedSprite.flip_h == false:
			thrown.apply_impulse(Vector2(),Vector2(-100, -300))
		else:
			thrown.apply_impulse(Vector2(),Vector2(100, -300))
		get_parent().add_child(thrown)

func _on_top_hit_area_entered(area):
	if area.get_parent().state == "fall" or area.get_parent().state == "land":
		if $death_timer.is_stopped():
			Globals.killed += 1
			Globals.GUI.update_gui(Globals.killed + Globals.score)
			$AnimatedSprite.animation = "die"
			$death_timer.start()

func _on_death_timer_timeout():
	add_to_group("dead")


func _on_thow_area_body_entered(body):
	if body.name != "Player":
		return
	if is_in_group("dead"):
		return
	if $death_timer.is_stopped():
		RandomDialog.on_active_dialog()
		throw_rubbish()

