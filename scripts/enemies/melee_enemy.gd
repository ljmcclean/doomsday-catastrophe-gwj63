extends CharacterBody2D

@export var speed := 30
@export var accel := 1500
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfind_timer := $PathfindTimer
@onready var attack_cooldown := $AttackCooldown
@onready var coin := preload("res://scenes/items/coin.tscn")

@export var player_data : Resource

@export var health := 3

var player_in_move_radius := false
var player_in_attack_radius := false

var is_dead: bool = false

var dasher: bool = false

func _ready():
	nav_agent.target_desired_distance = 1
	#if(randi() % 2 == 1):
	dasher = true


func _physics_process(delta):
	if !is_dead:
		if player_in_move_radius:
			var dir = to_local(nav_agent.get_next_path_position()).normalized()

			var target_velocity = dir * speed
			velocity = velocity.move_toward(target_velocity, accel * delta)
			
			move_and_slide()

		if health <= 0:
			die()


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

func _on_dash_radius_body_entered(body):
#	print(body)
#	if body.is_in_group("damage_source"):
#		print("it happened")
#		speed *= 4
	pass

func attack():
	if !is_dead:
		var tween = get_tree().create_tween()
		tween.tween_property($AttackArea, "scale", Vector2(2, 2), .4)
		tween.tween_property($AttackArea, "scale", Vector2(0, 0), .4)
		attack_cooldown.start()


func _on_pathfind_timer_timeout():
	nav_agent.target_position = player_data.player_position


func die():
	is_dead = true
	var tween = get_tree().create_tween()
	tween.tween_property($Temporary2, "modulate", Color.RED, 1)
	$DeathTimer.start()


func _on_attack_cooldown_timeout():
	if !is_dead:
		var tween = get_tree().create_tween()
		tween.tween_property($AttackArea, "scale", Vector2(2, 2), .4)
		tween.tween_property($AttackArea, "scale", Vector2(0, 0), .4)


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_damage_source"):
		health -= 1


func _on_death_timer_timeout():
	for i in randi_range(1, 4):
		var dropped_coin = coin.instantiate()
		get_tree().root.add_child(dropped_coin)
		dropped_coin.position = position + Vector2(randi_range(-15, 15), randi_range(-15, 15))
	queue_free()


func _on_dash_radius_area_entered(area):
	pass # Replace with function body.
