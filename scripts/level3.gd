extends Node

export var game_xpos_min = 70
export var game_xpos_max = 900
export var time_scale = 0.1
export var minimum_interval = 0.3

export var needed_points = 15
var game = preload("res://scenes/game.tscn")

func _on_Timer_timeout():
	add_games()
	$Timer.wait_time = clamp($Timer.wait_time - time_scale, minimum_interval, $Timer.wait_time)

func _process(delta):
	if Globals.score == needed_points:
		$portal/AnimationPlayer.play("portal")
		$portal/portal_timer.start()
		$DialogNode.portal_text()

func add_games():
	var i = game.instance()
	i.position = Vector2(rand_range(game_xpos_min,game_xpos_max),-50)
	i.rotation_degrees += rand_range(-10.0, 10.0)
	add_child(i)
	if rand_range(0.0,1.0) >= 0.5:
		i.sprite.texture = load("res://gfx/Goodgame.png")
		i.sprite2.texture = load("res://gfx/gamepad.png")
		i.add_to_group("good")
	else:
		if rand_range(0.0,1.0) <= 0.2:
			i.modulate = Color(0.2, 0.2, 0.2, 1.0)
			i.set_collision_mask_bit(0,true)
			#i.collision_mask = "player"
		elif rand_range(0.0,1.0) >= 0.6:
			i.modulate = Color(rand_range(0.0,1.0), rand_range(0.0,1.0), rand_range(0.0,1.0), 0.5)
			i.set_collision_mask_bit(1,false)
			i.set_collision_mask_bit(2,false)
			i.set_collision_layer_bit(1,false)
			i.add_to_group("ghostly")
		i.add_to_group("bad")
		i.remove_pickup()

func _on_portal_body_entered(body):
	Globals.active_ren()
	get_tree().change_scene_to(load("res://scenes/game_end.tscn"))
	Globals.GUI.hide()
	Globals.GUI.hide_ren()


func _on_portal_timer_timeout():
	$portal/AnimatedSprite.play("default")
