extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$NextSound.play()
		$LoadDelay.start()


func _on_load_delay_timeout():
	get_tree().change_scene_to_file("res://scenes/game_scenes/level_generator.tscn")
