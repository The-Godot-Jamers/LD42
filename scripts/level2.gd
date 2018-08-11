extends Node



func _ready():
	for i in 40:
		var xx = rand_range(0,98)
		var yy = rand_range(-16,16)
		$TileMap.set_cell(xx,yy,0)
		$TileMap.set_cell(xx-1,yy,0)
		$TileMap.set_cell(xx+1,yy,0)
	for z in 15:
		z = load("res://scenes/enemy1.tscn").instance()
		z.position = Vector2(rand_range(50,3000),rand_range(-500,500))
		add_child(z)
