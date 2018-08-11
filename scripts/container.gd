extends Node

func _ready():
	var balls = get_tree().get_nodes_in_group("balls")
	for i in balls:
		if rand_range(0.0,1.0) >= 0.5:
			i.modulate = Color(1.0, 0.0, 0.0, 1.0)
			i.add_to_group("good")
		else:
			i.add_to_group("bad")
	var goods = get_tree().get_nodes_in_group("good")
	Globals.GUI.update_gui(goods.size())