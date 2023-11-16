extends Node

@export var player_data : Resource
@export var upgrade_data_1 : Resource
@export var upgrade_data_2 : Resource
@export var upgrade_data_3 : Resource
@export var upgrade_data_4 : Resource

var first_play = true


func _ready():
	if first_play:
		first_play = false
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
		save_data()


func save_player():
	var save_dict = {
		"max_health" : player_data.max_health,
		"health" : player_data.health,
		"speed" : player_data.speed,
		"currency" : player_data.currency,
		"fire_rate" : player_data.fire_rate,
		"bullet_speed" : player_data.bullet_speed,
		"first_play" : player_data.first_play
	}
	return save_dict


func save_upgrades():
	save_upgrade1()
	save_upgrade2()
	save_upgrade3()
	save_upgrade4()


func save_self():
	var save_dict = {
		"first_play" : self.first_play
	}
	return save_dict


func save_upgrade1():
	var save_dict = {
		"cost" : upgrade_data_1.cost
	}
	return save_dict
func save_upgrade2():
	var save_dict = {
		"cost" : upgrade_data_2.cost
	}
	return save_dict
func save_upgrade3():
	var save_dict = {
		"cost" : upgrade_data_3.cost
	}
	return save_dict
func save_upgrade4():
	var save_dict = {
		"cost" : upgrade_data_4.cost
	}
	return save_dict


func save_data():
	var save_game = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	var save_data_player = save_player()
	var save_data_upgrade_1 = save_upgrade1()
	var save_data_upgrade_2 = save_upgrade2()
	var save_data_upgrade_3 = save_upgrade3()
	var save_data_upgrade_4 = save_upgrade4()
	var save_data_self = save_self()
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
	json_string = JSON.stringify(save_data_self)
	save_game.store_line(json_string)


func load_data():
	if not FileAccess.file_exists("user://savegame.dat"):
		return
	
	var save_game = FileAccess.open("user://savegame.dat", FileAccess.READ)
	var line_num := 0
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		print_debug(json_string)
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			continue
		
		var save_data = json.get_data()
		print_debug(save_data)
		
		for i in save_data.keys():
			if line_num == 0:
				player_data.set(i, save_data[i])
			elif line_num == 1:
				upgrade_data_1.set(i, save_data[i])
			elif line_num == 2:
				upgrade_data_2.set(i, save_data[i])
			elif line_num == 3:
				upgrade_data_3.set(i, save_data[i])
			elif line_num == 4:
				upgrade_data_4.set(i, save_data[i])
			elif line_num == 5:
				self.set(i, save_data[i])
			line_num += 1


