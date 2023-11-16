extends Control


##func _on_down_text_set():
##	if is_valid($VBoxContainer/Movement/Down.text):
##		InputMap.action_erase_events("down")
##		InputMap.action_add_event("down", $VBoxContainer/Movement/Down.text)
##	else:
##		$VBoxContainer/Movement/Up.text = ""
##
##
##func _on_up_text_set():
##	if is_valid($VBoxContainer/Movement/Up.text):
##		InputMap.action_erase_events("up")
##		InputMap.action_add_event("up", $VBoxContainer/Movement/Up.text)
##	else:
##		$VBoxContainer/Movement/Up.text = ""
##
##
##func _on_left_text_set():
##	if is_valid($VBoxContainer/Movement/Left.text):
##		InputMap.action_erase_events("left")
##		InputMap.action_add_event("left", $VBoxContainer/Movement/Left.text)
##	else:
##		$VBoxContainer/Movement/Up.text = ""
##
##
##func _on_right_text_set():
##	if is_valid($VBoxContainer/Movement/Right.text):
##		InputMap.action_erase_events("right")
##		InputMap.action_add_event("right", $VBoxContainer/Movement/Right.text)
##	else:
##		$VBoxContainer/Movement/Up.text = ""
##
##
##func is_valid(str : String) -> bool:
##	if len(str) == 1:
##		return true
##	return false
#
#
#func _on_up_text_changed():
#	var text: String = $VBoxContainer/Movement/Up.text
#	var current_text: String = ''
#	if len(text) <= 1:
#		current_text = $VBoxContainer/Movement/Up.text
#		InputMap.action_erase_events("up")
#		InputMap.action_add_event("up", OS.find_keycode_from_string($VBoxContainer/Movement/Up.text))
#	if len(text) > 1:
#		$VBoxContainer/Movement/Up.text = current_text
#
#
#func _on_down_text_changed():
#	var text: String = $VBoxContainer/Movement/Down.text
#	var current_text: String = ''
#	if len(text) <= 1:
#		current_text = $VBoxContainer/Movement/Down.text
#		InputMap.action_erase_events("down")
#		InputMap.action_add_event("down", $VBoxContainer/Movement/Down.text)
#	if len(text) > 1:
#		$VBoxContainer/Movement/Down.text = current_text
#
#
#func _on_left_text_changed():
#	var text: String = $VBoxContainer/Movement/Left.text
#	var current_text: String = ''
#	if len(text) <= 1:
#		current_text = $VBoxContainer/Movement/Left.text
#		InputMap.action_erase_events("left")
#		InputMap.action_add_event("left", $VBoxContainer/Movement/Left.text)
#	if len(text) > 1:
#		$VBoxContainer/Movement/Left.text = current_text
#
#
#func _on_right_text_changed():
#	var text: String = $VBoxContainer/Movement/Right.text
#	var current_text: String = ''
#	if len(text) <= 1:
#		current_text = $VBoxContainer/Movement/Right.text
#		InputMap.action_erase_events("right")
#		InputMap.action_add_event("right", $VBoxContainer/Movement/Right.text)
#	if len(text) > 1:
#		$VBoxContainer/Movement/Right.text = current_text
