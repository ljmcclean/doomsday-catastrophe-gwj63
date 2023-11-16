extends Resource

var max_health : int
var health : int
var speed : float
var is_dead : bool = false
var currency : int
var fire_rate : float
var bullet_speed : int

var player_position : Vector2
var spawn_location := Vector2i(535, 425)

var level_number : int


func upgrade(upgrade_name : String):
	if upgrade_name == "speed":
		speed += 10
	elif upgrade_name == "fire_rate":
		fire_rate -= .05
	elif upgrade_name == "health":
		max_health += 1
	elif upgrade_name == "bullet_speed":
		bullet_speed += 10
	
	health = clamp(max_health, 0, 8)
	speed = clamp(speed, 0, 180)
	fire_rate = clamp(fire_rate, .2, .35)
	bullet_speed = clamp(bullet_speed, 0, 400)
