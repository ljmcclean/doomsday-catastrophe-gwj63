extends Area2D


func _on_body_entered(body):
	if body.name == "Cat":
		queue_free()
		
		
