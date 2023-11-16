extends Node2D

@export var player_data : Resource

func _ready():
	player_data.spawn_location = Vector2i(535, 425)
	$Cat.respawn()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$NextSound.play()
		$LoadDelay.start()


func _on_load_delay_timeout():
	get_tree().change_scene_to_file("res://scenes/game_scenes/level_generator.tscn")
