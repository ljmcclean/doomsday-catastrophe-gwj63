extends CharacterBody2D

@export var speed = 100
var chase_player = false
var player = null


func _physics_process(delta):
	if chase_player:
		position += (player.position - position) / speed
		

func _on_detection_area_body_entered(body):
	player = body
	chase_player = true


func _on_detection_area_body_exited(body):
	player = null
	chase_player = false
