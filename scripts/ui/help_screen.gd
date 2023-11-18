extends Control

var active: bool = false


func start():
	$Music.play()


func _on_button_pressed():
	get_tree().paused = false
	get_parent().hide()
	$Music.stop()
	get_parent().set_process(false)
