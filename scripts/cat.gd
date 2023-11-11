extends CharacterBody2D
#Primary Programmer: Daek

@export var speed : float
@export var friction : float
@export var acceleration : float


func _physics_process(delta):
	var direction := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = direction.normalized()
	
	var target_velocity: Vector2 = direction * speed
#applies friction multiplier rather than acceleration if attempting to change direction of motion
	if (direction != Vector2.ZERO) and direction.dot(velocity) > 0:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(target_velocity, friction * delta)
	
	move_and_slide()
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
