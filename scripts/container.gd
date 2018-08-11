extends Node

export var game_xpos_min = 35
export var game_xpos_max = 735
export var time_scale = 0.1

var game = preload("res://scenes/game.tscn")

func _on_Timer_timeout():
	add_games()
	$Timer.wait_time = clamp($Timer.wait_time - time_scale, 0.1, $Timer.wait_time)

func add_games():
	var i = game.instance()
	i.position = Vector2(rand_range(game_xpos_min,game_xpos_max),-50)
	add_child(i)
	if rand_range(0.0,1.0) >= 0.5:
		i.sprite.texture = load("res://gfx/Goodgame.png")
		#i.sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
		i.add_to_group("good")
	else:
		i.add_to_group("bad")
		i.remove_pickup()
	
	