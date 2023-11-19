extends CharacterBody2D
#Primary Programmer: Daek/Lucks

var player: bool = true

@export var friction : float
@export var acceleration : float

@export var player_data : Resource

@onready var gun = $Gun
@onready var walking_sound = $WalkingSound
@onready var anim = $AnimationPlayer

var nor_modulate : Color

signal player_died


func _ready():
	nor_modulate = $Sprite.modulate
	add_to_group("cat")


func _physics_process(delta):
	if not player_data.is_dead:
		aim_gun()
		move(delta)
		play_animation()
		move_and_slide()
	update_player_data()
	if player_data.health <= 0:
		die()


func move(delta):
	var direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = direction.normalized()
	if !walking_sound.playing and direction != Vector2.ZERO:
		walking_sound.play()
	elif direction == Vector2.ZERO:
		walking_sound.stop()
	
	var target_velocity: Vector2 = direction * player_data.speed
#applies friction multiplier rather than acceleration if attempting to change direction of motion
	if (direction != Vector2.ZERO) and direction.dot(velocity) > 0:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(target_velocity, friction * delta)


func aim_gun():
	$Gun.global_rotation = $Gun.global_position.direction_to(get_global_mouse_position()).angle() + PI/2


func _input(event):
	if event.is_action_pressed("shoot"):
		gun.fire_bullet()
	if event.is_action_pressed("ui_select"):
		player_data.health = 100


func _on_hurt_box_area_entered(area):
	if area.is_in_group("damage_source"):
		player_data.health -= 1
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite, "modulate", Color.DIM_GRAY, .2)
		tween.tween_property($Sprite, "modulate", nor_modulate, .1)


func die():
	if !player_data.is_dead:
		await SaveAndLoad.save_data()
		$Camera2D/LoadDelay.start()
		var tween = get_tree().create_tween()
		tween.tween_property($Camera2D/GameUI/Black, "modulate", Color(1, 1, 1, 1), .4)
		player_data.is_dead = true


func respawn():
	player_data.is_dead = false
	player_data.health = player_data.max_health


#updates player_data resource which can be accessed by other scripts
func update_player_data():
	if player_data.coin_pickedup:
		$CoinPickup.play()
		player_data.coin_pickedup = false
	player_data.player_position = self.position
	if player_data.health <= 0 and !player_data.is_dead:
		die()
	$Gun.cooldown = player_data.fire_rate
	$Gun.bullet_speed = player_data.bullet_speed


#Makes the player dodge to the direction of the mouse 
func dodge():
	pass


func _on_load_delay_timeout():
	emit_signal("player_died")


func play_animation():
	if velocity.normalized() == Vector2(1, 0):
		anim.play("right")
	elif velocity.normalized() == Vector2(-1, 0):
		anim.play("left")
	elif velocity.normalized() == Vector2(0, -1):
		anim.play("up")
	elif velocity.normalized() == Vector2(0, 1):
		anim.play("down")
	if velocity.normalized() == (Vector2.RIGHT + Vector2.UP).normalized():
		anim.play("up_right")
	elif velocity.normalized() == (Vector2.LEFT + Vector2.UP).normalized():
		anim.play("up_left")
	elif velocity.normalized() == (Vector2.LEFT + Vector2.DOWN).normalized():
		anim.play("down_left")
	elif velocity.normalized() == (Vector2.RIGHT + Vector2.DOWN).normalized():
		anim.play("down_right")
	elif velocity.normalized() == Vector2.ZERO:
		anim.play("sit")

