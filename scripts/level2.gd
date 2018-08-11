extends Node


func _ready():
	for i in 100:
		$TileMap.set_cell(rand_range(0,98),rand_range(-16,16),0)

