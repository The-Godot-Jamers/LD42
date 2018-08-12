extends KinematicBody2D

const UP = Vector2(0,-1)
export(String) var character_id = ""
export(String) var character_name = ""
# export(Color) var color = Color("#ffffff") 
# export(PackedScene) var avatar 
# export(GDScript) var dialog_script = GDScript.new() setget set_dialog_script, get_dialog_script

export var speed = 50
export var motion = Vector2()
export var jump_height = -1000
export var gravity = 2400
export var max_fall_speed = 4000
export var stop_min_velocity = 5
export var max_bounces = 4
export var slope_angle = 1.308996939

var start = true
var kwargs = {}

func _ready():
	set_kwargs({"name": character_name})
	# set_kwargs({"color":color.to_html()})
	# if avatar != null:
	# 	set_kwargs({"avatar":avatar.resource_path})
	Ren.character(character_id, kwargs, self)
	$DialogNode.parent = name

func set_kwargs(new_kwargs):
	# update character
	for kws in new_kwargs:
		kwargs[kws] = new_kwargs[kws]

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
	if body.name != "Player":
		return
	prints(name, "was kill")
	queue_free()

func _on_Timer_timeout():
	start = !start

# func set_dialog_script():
# 	$DialogNode.set_script(dialog_script)

# func get_dialog_script():
# 	return $DialogNode.get_script()

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	
	$DialogNode.on_active_dialog()

