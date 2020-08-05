extends CanvasLayer
class_name ScreenMenu
"""
Does XXX.
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

func _ready():
	SaveManager.do_load()
	if PlayerData.current_level == 0:
		$CenterContainer/VBoxContainer/Play.visible = true
		$CenterContainer/VBoxContainer/Continue.disabled = true
		$CenterContainer/VBoxContainer/LevelSelect.disabled = true
	
func _on_Play_pressed():
	match PlayerData.current_level:
		0: get_tree().change_scene("res://src/screen_intro/ScreenIntro.tscn")
		1: get_tree().change_scene("res://src/levels/Level_1.tscn")
		2: get_tree().change_scene("res://src/levels/Level_2.tscn")
		3: get_tree().change_scene("res://src/levels/Level_3.tscn")

func _on_Level_Select_pressed():
	pass # Replace with function body.

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Exit_pressed():
	pass # Replace with function body.

""" PUBLIC """

