extends Control


func _ready():
	$MainMenuMusic.play()
	var tween = get_tree().create_tween()
	tween.tween_property($MainMenuMusic, "volume_db", 0, .38)
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$LoadDelay.start()
		var tween = get_tree().create_tween()
		tween.tween_property($Black, "modulate", Color(0, 0, 0, 1), .4)
		tween.tween_property($MainMenuMusic, "volume_db", -80, .38)
		$StartSound.play()


func _on_load_delay_timeout():
	if SaveAndLoad.first_run:
		SaveAndLoad.first_run = false
		get_tree().change_scene_to_file("res://scenes/game_scenes/opening_scroll.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game_scenes/lobby.tscn")


func _on_main_menu_music_finished():
	$MainMenuMusic.play()
