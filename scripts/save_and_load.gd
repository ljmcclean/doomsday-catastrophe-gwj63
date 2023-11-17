extends Node

@export var player_data : Resource
@export var upgrade_data_1 : Resource
@export var upgrade_data_2 : Resource
@export var upgrade_data_3 : Resource
@export var upgrade_data_4 : Resource


func _ready():
	get_tree().set_auto_accept_quit(false)
	player_data.health = 5
	if not FileAccess.file_exists("user://savegame.dat"):
		player_data.max_health = 5
		player_data.health = 5
		player_data.speed = 100
		player_data.currency = 0
		player_data.fire_rate = .35
		player_data.bullet_speed = 200
		upgrade_data_4.cost = 10
		upgrade_data_3.cost = 25
		upgrade_data_2.cost = 15
		upgrade_data_1.cost = 20
		await save_data()
	load_data()


func save_player():
	var save_dict = {
		"max_health" : player_data.max_health,
		"health" : player_data.health,
		"speed" : player_data.speed,
		"currency" : player_data.currency,
		"fire_rate" : player_data.fire_rate,
		"bullet_speed" : player_data.bullet_speed
	}
	if save_dict.max_health == null:
		print_debug("saved null value")
	return save_dict


func save_upgrades():
	save_upgrade1()
	save_upgrade2()
	save_upgrade3()
	save_upgrade4()


func save_upgrade1():
	var save_dict = {
		"cost1" : upgrade_data_1.cost
	}
	return save_dict
func save_upgrade2():
	var save_dict = {
		"cost2" : upgrade_data_2.cost
	}
	return save_dict
func save_upgrade3():
	var save_dict = {
		"cost3" : upgrade_data_3.cost
	}
	return save_dict
func save_upgrade4():
	var save_dict = {
		"cost4" : upgrade_data_4.cost
	}
	return save_dict


func save_data():
	var save_game = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	var save_data_player = save_player()
	var save_data_upgrade_1 = save_upgrade1()
	var save_data_upgrade_2 = save_upgrade2()
	var save_data_upgrade_3 = save_upgrade3()
	var save_data_upgrade_4 = save_upgrade4()
	var json_string = JSON.stringify(save_data_player)
	save_game.store_line(json_string)
	json_string = JSON.stringify(save_data_upgrade_1)
	save_game.store_line(json_string)
	json_string = JSON.stringify(save_data_upgrade_2)
	save_game.store_line(json_string)
	json_string = JSON.stringify(save_data_upgrade_3)
	save_game.store_line(json_string)
	json_string = JSON.stringify(save_data_upgrade_4)
	save_game.store_line(json_string)


func load_data():
	player_data.health = 5
	if not FileAccess.file_exists("user://savegame.dat"):
		return
	
	var save_game = FileAccess.open("user://savegame.dat", FileAccess.READ)
	
	var line_num: int = 0
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			continue
		
		var save_data = json.get_data()
		
		if line_num == 0:
			player_data.max_health = save_data["max_health"]
			player_data.health = save_data["health"]
			player_data.speed = save_data["speed"]
			player_data.currency = save_data["currency"]
			player_data.fire_rate = save_data["fire_rate"]
			player_data.bullet_speed = save_data["bullet_speed"]
		elif line_num == 1:
			upgrade_data_1.cost = save_data["cost1"]
		elif line_num == 2:
			upgrade_data_2.cost = save_data["cost2"]
		elif line_num == 3:
			upgrade_data_3.cost = save_data["cost3"]
		elif line_num == 4:
			upgrade_data_4.cost = save_data["cost4"]
		line_num += 1


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await save_data()
		get_tree().quit() 
