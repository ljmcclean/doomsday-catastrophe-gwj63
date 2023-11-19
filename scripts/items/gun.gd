extends Sprite2D

var bullet_scene := preload("res://scenes/items/bullet.tscn")

@export var is_player: bool = false
@export var cooldown: float = .35
@export var bullet_speed: int = 200
@export var spread: float = 0

var can_shoot : bool = true
var bufferedShot = false

func fire_bullet():
	if can_shoot:
		var bullet = bullet_scene.instantiate()
		if is_player:
			bullet.is_player = true
		bullet.speed = bullet_speed
		get_tree().root.add_child.call_deferred(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation + randf_range(-spread, spread)
		$ShootSound.play()
		can_shoot = false
		$Cooldown.start()
		bufferedShot = false
	else:
		if $Cooldown.time_left < 0.1:
			bufferedShot = true
		$ShootSound.pitch_scale = 8
		$ShootSound.play()


func _on_cooldown_timeout():
	$ShootSound.pitch_scale = 1
	can_shoot = true
	if bufferedShot:
		fire_bullet()
