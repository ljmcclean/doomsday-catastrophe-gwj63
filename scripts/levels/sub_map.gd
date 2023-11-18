extends TileMap


func generate_sub_map(theme : String):
	var cell = Vector2i(-550, -460)
	#outdoor
	if theme == "outdoor":
		for x in range(1100):
			for y in range(500):
				set_cell(0, Vector2i(cell.x+x, cell.y+y), 1, Vector2i(randi_range(0, 1), 0))
				#backyard
	elif theme == "backyard":
		for x in range(1100):
			for y in range(500):
				set_cell(0, Vector2i(cell.x+x, cell.y+y), 1, Vector2i(randi_range(18, 19), randi_range(5, 6)))
	#indoor
	elif theme == "indoor":
		for x in range(1100):
			for y in range(500):
				set_cell(0, Vector2i(cell.x+x, cell.y+y), 1, Vector2i(randi_range(0, 1), 0))
