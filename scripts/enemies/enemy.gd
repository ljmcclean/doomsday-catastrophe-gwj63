extends CharacterBody2D


@export var speed := 30
@export var accel := 1500
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfind_timer := $PathfindTimer
@onready var attack_cooldown := $AttackCooldown
@onready var gun := $Gun

@export var player_data : Resource

var health := 3

var player_in_move_radius := false
var player_in_attack_radius := false

var is_dead: bool = false


func _ready():
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
			gun.global_rotation = gun.global_position.direction_to(player_data.player_position).angle() + PI


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
	tween.tween_property($Temporary2, "modulate", Color.RED, 1)
	$DeathTimer.start()


func _on_attack_cooldown_timeout():
	if !is_dead:
		gun.fire_bullet()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_damage_source"):
		health -= 1


func _on_death_timer_timeout():
	queue_free()


func _on_stop_move_radius_body_entered(body):
	if body.is_in_group("player"):
		pathfind_timer.stop()
		player_in_move_radius = false


func _on_stop_move_radius_body_exited(body):
	if body.is_in_group("player"):
		player_in_move_radius = true
		pathfind_timer.start()
