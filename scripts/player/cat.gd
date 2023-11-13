extends CharacterBody2D
#Primary Programmer: Daek/Lucks

@export var speed : float
@export var friction : float
@export var acceleration : float

@export var player_data : Resource

@onready var gun = $Gun
@onready var walking_sound = $WalkingSound


func _ready():
	respawn()
	add_to_group("cat")


func _physics_process(delta):
	if not player_data.is_dead:
		move(delta)
		move_and_slide()
	update_player_data()


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
	
	var target_velocity: Vector2 = direction * speed
#applies friction multiplier rather than acceleration if attempting to change direction of motion
	if (direction != Vector2.ZERO) and direction.dot(velocity) > 0:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(target_velocity, friction * delta)
	
	$Gun.global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI


func _input(event):
	if event.is_action_pressed("shoot"):
		gun.fire_bullet()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("damage_source"):
		player_data.health -= 1


func die():
	position = Vector2(INF, INF)
	respawn()


func respawn():
	player_data.health = 5
	position = player_data.spawn_location


#updates player_data resource which can be accessed by other scripts
func update_player_data():
	player_data.player_position = self.position
	if player_data.health <= 0:
		die()

#Makes the player dodge to the direction of the mouse 
func dodge():
	pass

