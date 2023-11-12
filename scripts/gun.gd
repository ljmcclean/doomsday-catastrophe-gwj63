extends Sprite2D

var bullet_scene := preload("res://scenes/bullet.tscn")


func fire_bullet():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation-PI/2
	$ShootSound.play()
