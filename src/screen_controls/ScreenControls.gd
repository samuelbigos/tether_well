extends CanvasLayer
class_name ScreenControls
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _input(event):
	pass

""" PUBLIC """

func _on_ControlA_mouse_entered():
	$CenterContainer/VBoxContainer/ControlA/VBoxContainer/Label.set("custom_colors/font_color", Color("ba5044"))

func _on_ControlA_mouse_exited():
	$CenterContainer/VBoxContainer/ControlA/VBoxContainer/Label.set("custom_colors/font_color", Color("eff9d6"))

func _on_ControlA_pressed():
	PlayerData.control_method = 0
	SaveManager.do_save()
	AudioPlayer.on_click()
	if PlayerData.came_from_options:
		get_tree().change_scene("res://src/screen_options/ScreenOptions.tscn")
		PlayerData.came_from_options = false
	else:
		get_tree().change_scene("res://src/screen_intro/ScreenIntro.tscn")

func _on_ControlB_mouse_entered():
	$CenterContainer/VBoxContainer/ControlB/VBoxContainer/Label.set("custom_colors/font_color", Color("ba5044"))

func _on_ControlB_mouse_exited():
	$CenterContainer/VBoxContainer/ControlB/VBoxContainer/Label.set("custom_colors/font_color", Color("eff9d6"))

func _on_ControlB_pressed():
	PlayerData.control_method = 1
	SaveManager.do_save()
	AudioPlayer.on_click()
	if PlayerData.came_from_options:
		get_tree().change_scene("res://src/screen_options/ScreenOptions.tscn")
		PlayerData.came_from_options = false
	else:
		get_tree().change_scene("res://src/screen_intro/ScreenIntro.tscn")
