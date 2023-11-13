extends CharacterBody2D

@export var speed = 25
var chase_player = false
var player = null


func _physics_process(delta):
	if chase_player:
		velocity = (player.global_position - position).normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
		

func _on_detection_area_body_entered(body):
	player = body
	chase_player = true


func _on_detection_area_body_exited(body):
	player = null
	chase_player = false
