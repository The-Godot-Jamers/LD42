extends Node



func _ready():
	for i in 40:
		var xx = rand_range(5,98)
		var yy = rand_range(-16,16)
		$TileMap.set_cell(xx,yy,0)
		$TileMap.set_cell(xx-1,yy,0)
		$TileMap.set_cell(xx+1,yy,0)
	for z in 15:
		z = load("res://scenes/enemy1.tscn").instance()
		z.position = Vector2(rand_range(100,3000),rand_range(-500,500))
		add_child(z)
		var pos = $TileMap.world_to_map(z.position)
		pos.x -=1
		pos.y -=1
		for xx in 3:
			for yy in 3:
				if $TileMap.get_cellv(pos) != -1:
					$TileMap.set_cellv(pos,-1)
				pos.y +=1
			pos.y -= 3
			pos.x +=1
