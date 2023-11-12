extends Node2D
#Primary Programmer: Lucks

@export var current_level : TileMap
@onready var room_templates: Node = get_node("/root/RoomTemplates")
@onready var hall_templates_hor: Node = get_node("/root/HallTemplatesHor")
@onready var hall_templates_ver: Node = get_node("/root/HallTemplatesVer")

@export var room_size := Vector2i(23, 15)
@export var hall_size := Vector2i(7, 11)
@export var num_rooms: int = 15
var theme : String
var rooms : Array
var halls_hor : Array
var halls_ver : Array

var rooms_placed : Array


func _ready():
	reset()
	for room in room_templates.get_children():
		rooms.append(room)
	for hall in hall_templates_hor.get_children():
		halls_hor.append(hall)
	for hall in hall_templates_ver.get_children():
		halls_ver.append(hall)
	generate_level()


func generate_level() -> void:
	var used_coords: Array = [Vector2i(0, 0)]
	var current_coords := Vector2i(0, 0)
	var direction : int
	var last_dir : int
	
	generate_room(current_coords)
	rooms_placed.append(current_coords)
	for _i in range(num_rooms-1):
		while current_coords in used_coords:
			direction = randi_range(1, 3)
			while direction == last_dir:
				direction = randi_range(1, 3)
			if direction == 1:
				current_coords = current_coords - Vector2i(room_size.x + hall_size.y, 0)
			elif direction == 2:
				current_coords = current_coords - Vector2i(0, room_size.y + hall_size.y)
			elif direction == 3:
				current_coords = current_coords + Vector2i(room_size.x + hall_size.y, 0)
		last_dir = direction
		
		generate_room(current_coords)
		used_coords.append(current_coords)
		rooms_placed.append(current_coords)
	place_halls()


func place_halls() -> void:
	for room_coords in rooms_placed:
		if room_coords + Vector2i(room_size.x + hall_size.y, 0) in rooms_placed:
			generate_hall(room_coords, "horizontal", "left")
		if room_coords + Vector2i(0, room_size.y + hall_size.y) in rooms_placed:
			generate_hall(room_coords, "vertical", "none")
		if room_coords - Vector2i(room_size.x + hall_size.y, 0) in rooms_placed:
			generate_hall(room_coords, "horizontal", "right")


func generate_room(coords : Vector2i) -> void:
	var current_room : TileMap = rooms[randi_range(0, len(rooms)-1)]
	for x in room_size.x:
		for y in room_size.y:
			var cell = Vector2i(x+coords.x, y+coords.y)
			current_level.set_cell(0, cell, 0, current_room.get_cell_atlas_coords(0, Vector2i(x, y)))


func generate_hall(coords : Vector2i, orientation : String, direction : String) -> void:
	if orientation == "horizontal" and direction == "right":
		var current_hall : TileMap = halls_hor[randi_range(0, len(halls_hor)-1)]
		for x in hall_size.y:
			for y in hall_size.x:
				var cell = Vector2i(x+coords.x-hall_size.y, y+coords.y+(room_size.y/2)-(hall_size.x/2))
				current_level.set_cell(0, cell, 0, current_hall.get_cell_atlas_coords(0, Vector2i(x, y)))
	elif orientation == "horizontal" and direction == "left":
		var current_hall : TileMap = halls_hor[randi_range(0, len(halls_hor)-1)]
		for x in hall_size.y:
			for y in hall_size.x:
				var cell = Vector2i(x+coords.x+room_size.x, y+coords.y+(room_size.y/2)-(hall_size.x/2))
				current_level.set_cell(0, cell, 0, current_hall.get_cell_atlas_coords(0, Vector2i(x, y)))
	elif orientation == "vertical":
		var current_hall : TileMap = halls_ver[randi_range(0, len(halls_ver)-1)]
		for x in hall_size.x:
			for y in hall_size.y:
				var cell = Vector2i(x+coords.x+(room_size.x/2)-(hall_size.x/2), y+coords.y+room_size.y)
				current_level.set_cell(0, cell, 0, current_hall.get_cell_atlas_coords(0, Vector2i(x, y)))


func reset():
	rooms.clear()
	halls_hor.clear()
	halls_ver.clear()
	rooms_placed.clear()
	current_level.clear()
