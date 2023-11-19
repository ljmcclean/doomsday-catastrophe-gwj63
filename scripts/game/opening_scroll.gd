extends Control


func _ready():
	var tween = get_tree().create_tween()
	$Music.play()
	tween.tween_property($Music, "volume_db", 0, .5)
	await get_tree().create_timer(3).timeout
	$Timer.start()


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($Title, "modulate", Color(1, 1, 1, 0), 1.5)
	tween.tween_property($RichTextLabel, "position", Vector2(0, -3000), 100)
	$Timer2.start()


func _on_timer_2_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($Black, "modulate", Color(0, 0, 0, 1), 1)
	tween.tween_property($Music, "volume_db", -80, .5)
	$Timer3.start()


func _on_timer_3_timeout():
	get_tree().change_scene_to_file("res://scenes/game_scenes/lobby.tscn")
