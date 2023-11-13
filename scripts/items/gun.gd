extends Sprite2D

var bullet_scene := preload("res://scenes/items/bullet.tscn")

@export var is_player: bool = false

var can_shoot : bool = true


func fire_bullet():
	if can_shoot:
		var bullet = bullet_scene.instantiate()
		if is_player:
			bullet.is_player = true
		get_tree().root.add_child.call_deferred(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation-PI/2
		$ShootSound.play()
		can_shoot = false
		$Cooldown.start()
	else:
		$ShootSound.pitch_scale = 8
		$ShootSound.play()


func _on_cooldown_timeout():
	$ShootSound.pitch_scale = 1
	can_shoot = true
