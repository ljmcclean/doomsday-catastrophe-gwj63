extends Control


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$LoadDelay.start()
		var tween = get_tree().create_tween()
		tween.tween_property($Black, "modulate", Color(1, 1, 1, 1), .4)
		$StartSound.play()


func _on_load_delay_timeout():
	get_tree().change_scene_to_file("res://scenes/game_scenes/lobby.tscn")
