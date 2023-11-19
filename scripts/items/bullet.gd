extends CharacterBody2D

var speed: int = 150

var is_player: bool = false

var immune: bool = true


func _ready():
	if is_player:
		$Area2D.add_to_group("player_damage_source")
		$Area2D.remove_from_group("damage_source")
	$DecayTimer.start()


func _physics_process(_delta):
	velocity = speed * Vector2.from_angle(rotation-PI/2)
	move_and_slide()


func _on_area_2d_body_entered(body):
		if "player_damage_source" in $Area2D.get_groups() and !body.is_in_group("player"):
			if !immune or body.is_in_group("enemy"):
				queue_free()
		elif "damage_source" in $Area2D.get_groups() and !body.is_in_group("enemy"):
			if !immune or body.is_in_group("player"):
				queue_free()


func _on_decay_timer_timeout():
	queue_free()


func _on_immunity_timeout():
	immune = false
