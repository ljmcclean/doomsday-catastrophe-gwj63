extends Control

@export var player_data : Resource


func _process(delta):
	change_hearts()


func change_hearts():
	if player_data.health == 5:
		$HBoxContainer/Heart5.show()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 4:
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 3:
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 2:
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 1:
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.hide()
		$HBoxContainer/Heart1.show()
	if player_data.health == 0:
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.hide()
		$HBoxContainer/Heart1.hide()
