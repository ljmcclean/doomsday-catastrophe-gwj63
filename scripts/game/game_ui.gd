extends Control

@export var player_data : Resource


func _process(_delta):
	change_hearts()
	$MarginContainer/Currency.text = str(player_data.currency)


func change_hearts():
	if player_data.health == 8:
		$HBoxContainer/Heart8.show()
		$HBoxContainer/Heart7.show()
		$HBoxContainer/Heart6.show()
		$HBoxContainer/Heart5.show()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 7:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.show()
		$HBoxContainer/Heart6.show()
		$HBoxContainer/Heart5.show()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 6:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.show()
		$HBoxContainer/Heart5.show()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 5:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.show()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 4:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.show()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 3:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.show()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 2:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.show()
		$HBoxContainer/Heart1.show()
	if player_data.health == 1:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.hide()
		$HBoxContainer/Heart1.show()
	if player_data.health == 0:
		$HBoxContainer/Heart8.hide()
		$HBoxContainer/Heart7.hide()
		$HBoxContainer/Heart6.hide()
		$HBoxContainer/Heart5.hide()
		$HBoxContainer/Heart4.hide()
		$HBoxContainer/Heart3.hide()
		$HBoxContainer/Heart2.hide()
		$HBoxContainer/Heart1.hide()
