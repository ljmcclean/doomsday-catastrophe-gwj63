extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")  

func _physics_process(delta):
	velocity = velocity.move_toward(player.player_data.player_position - position, delta * 10)
	move_and_slide()
