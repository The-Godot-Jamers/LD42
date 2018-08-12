extends KinematicBody2D

const UP = Vector2(0,-1)
export(String) var character_id = "" setget set_character_id, get_character_id
export(String) var character_name = "" setget set_character_name, get_character_name
export(Color) var color = Color("#ffffff") setget set_color, get_color
export(PackedScene) var avatar setget set_avatar, get_avatar
export(GDScript) var dialog_script = GDScript() setget set_dialog_script, get_dialog_script

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
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _on_top_hit_body_entered(body):
	queue_free()

func _on_Timer_timeout():
	start = !start

func set_character_id(value):
	$Character.character_id = value

func get_character_id():
	return $Character.character_id

func set_character_name(value):
	$Character.character_name = value

func get_character_name():
	return $Character.character_name

func set_color(value):
	$Character.color = value

func get_color():
	return $Character.color

func set_avatar(value):
	$Character.avatar = value

func get_avatar():
	return $Character.avatar

func set_dialog_script():
	$DialogNode.set_script(dialog_script)

func get_dialog_script():
	return $DialogNode.get_script()
