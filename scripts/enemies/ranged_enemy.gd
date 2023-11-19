extends CharacterBody2D

@export var speed := 30
@export var accel := 1500
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfind_timer := $PathfindTimer
@onready var attack_cooldown := $AttackCooldown
@onready var gun := $Gun
@onready var coin := preload("res://scenes/items/coin.tscn")

@export var player_data : Resource

@export var health := 3

var player_in_move_radius := false
var player_in_attack_radius := false

var is_dead: bool = false

var nor_modulate : Color


func _ready():
	nor_modulate = $Sprite.modulate
	nav_agent.target_desired_distance = 1


func _physics_process(delta):
	if !is_dead:
		if player_in_move_radius:
			var dir = to_local(nav_agent.get_next_path_position()).normalized()

			var target_velocity = dir * speed
			velocity = velocity.move_toward(target_velocity, accel * delta)
			
			move_and_slide()

		if health <= 0:
			die()
		
		if player_in_attack_radius:
			gun.global_rotation = gun.global_position.direction_to(player_data.player_position).angle() + PI/2


func _on_attack_radius_body_entered(body):
	if body.is_in_group("player"):
		player_in_attack_radius = true
		attack()


func _on_attack_radius_body_exited(body):
	if body.is_in_group("player"):
		player_in_attack_radius = false
		attack_cooldown.stop()


func _on_move_radius_body_entered(body):
	if body.is_in_group("player"):
		player_in_move_radius = true
		pathfind_timer.start()


func _on_move_radius_body_exited(body):
	if body.is_in_group("player"):
		pathfind_timer.stop()
		player_in_move_radius = false


func attack():
	if !is_dead:
		gun.fire_bullet()
		attack_cooldown.start()


func _on_pathfind_timer_timeout():
	nav_agent.target_position = player_data.player_position


func die():
	is_dead = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite, "modulate", Color.RED, 1)
	$DeathTimer.start()


func _on_attack_cooldown_timeout():
	if !is_dead:
		gun.fire_bullet()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_damage_source"):
		health -= 1
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite, "modulate", Color.DIM_GRAY, .2)
		tween.tween_property($Sprite, "modulate", nor_modulate, .1)


func _on_death_timer_timeout():
	for i in randi_range(1, 4):
		var dropped_coin = coin.instantiate()
		get_tree().root.add_child(dropped_coin)
		dropped_coin.position = position + Vector2(randi_range(-15, 15), randi_range(-15, 15))
	queue_free()


func _on_stop_move_radius_body_entered(body):
	if body.is_in_group("player"):
		pathfind_timer.stop()
		player_in_move_radius = false


func _on_stop_move_radius_body_exited(body):
	if body.is_in_group("player"):
		player_in_move_radius = true
		pathfind_timer.start()
