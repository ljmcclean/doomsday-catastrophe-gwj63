extends Node2D

@export var player_data : Resource

func _ready():
	if FileAccess.file_exists("user://savegame.dat"):
		SaveAndLoad.load_data()
	player_data.spawn_location = Vector2i(535, 425)
	$Cat.respawn()
	$LobbyLoop.play()
	var tween = get_tree().create_tween()
	tween.tween_property($Cat/Camera2D/Black, "modulate", Color(1, 1, 1, 0), .4)
	tween.tween_property($LobbyLoop, "volume_db", 0, .4)


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var tween = get_tree().create_tween()
		tween.tween_property($Cat/Camera2D/Black, "modulate", Color(1, 1, 1, 1), .4)
		tween.tween_property($LobbyLoop, "volume_db", -80, .3)
		$NextSound.play()
		$LoadDelay.start()


func _on_load_delay_timeout():
	SaveAndLoad.save_data()
	get_tree().change_scene_to_file("res://scenes/game_scenes/level_generator.tscn")
