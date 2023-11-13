extends Sprite2D

var bullet_scene := preload("res://scenes/items/bullet.tscn")

@export var is_player: bool = false


func fire_bullet():
	var bullet = bullet_scene.instantiate()
	if is_player:
		bullet.is_player = true
	get_tree().root.add_child.call_deferred(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation-PI/2
	$ShootSound.play()
