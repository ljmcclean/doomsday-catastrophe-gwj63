extends CharacterBody2D

var speed: int = 200


func _ready():
	$DecayTimer.start()


func _physics_process(delta):
	velocity = speed * Vector2.from_angle(rotation-PI/2)
	move_and_slide()


func _on_area_2d_body_entered(body):
	queue_free()


func _on_decay_timer_timeout():
	queue_free()
