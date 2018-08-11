extends Node

export var ball_xpos_min = 35
export var ball_xpos_max = 735
export var time_scale = 0.1

var ball = preload("res://scenes/ball.tscn")

func _on_Timer_timeout():
	add_balls()
	$Timer.wait_time = clamp($Timer.wait_time - time_scale, 0.1, $Timer.wait_time)

func add_balls():
	var i = ball.instance()
	i.position = Vector2(rand_range(ball_xpos_min,ball_xpos_max),-50)
	if rand_range(0.0,1.0) >= 0.5:
		i.modulate = Color(1.0, 0.0, 0.0, 1.0)
		i.add_to_group("good")
	else:
		i.add_to_group("bad")
	add_child(i)
	#update GUI with good balls
	var goods = get_tree().get_nodes_in_group("good")
	Globals.GUI.update_gui(goods.size())