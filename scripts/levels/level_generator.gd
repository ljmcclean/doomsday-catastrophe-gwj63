extends Node2D
#Primary Programmer: Lucks

@export var current_level : TileMap
@onready var room_templates: Node = get_node("/root/RoomTemplates")
@onready var hall_templates: Node = get_node("/root/HallTemplates")

@export var room_size := Vector2i(22, 15)
@export var hall_size := Vector2i(7, 11)
@export var num_rooms: int = 15
var theme : String
var rooms : Array
var halls : Array
var rooms_generated: int = 0


func _ready():
	for room in room_templates.get_children():
		rooms.append(room)
	for hall in hall_templates.get_children():
		halls.append(hall)
	current_level.clear()
	generate_level()


func generate_level() -> void:
	var used_coords: Array = [Vector2i(0, 0)]
	var current_coords := Vector2i(0, 0)
	var direction : int
	var last_dir : int
	generate_room(current_coords)
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


func generate_room(coords : Vector2i):
	var current_room : TileMap = rooms[randi_range(0, len(rooms)-1)]
	for x in room_size.x:
		for y in room_size.y:
			var cell = Vector2i(x+coords.x, y+coords.y)
			current_level.set_cell(0, cell, 0, current_room.get_cell_atlas_coords(0, Vector2i(x, y)))

#func generate_halls():
