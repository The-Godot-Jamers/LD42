extends KinematicBody2D

const UP = Vector2(0,-1)
export(String) var character_id = ""
export(String) var character_name = ""

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
	add_to_group("enemies")
	set_kwargs({"name": character_name})
	Ren.character(character_id, kwargs, self)
	$DialogNode.parent = name

func set_kwargs(new_kwargs):
	# update character
	for kws in new_kwargs:
		kwargs[kws] = new_kwargs[kws]

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
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

	
func _on_Timer_timeout():
	start = !start

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	if is_in_group("dead"):
		return
	$DialogNode.on_active_dialog()

func _on_top_hit_area_entered(area):
	if area.get_parent().state == "fall":
		$DialogNode.disconnect("story_step", self, "story")
		Globals.score += 1
		$AnimatedSprite.animation = "die"
		$death_timer.start()

func _on_death_timer_timeout():
	add_to_group("dead")





