extends CanvasLayer
class_name ScreenMenu
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

func _ready():
	SaveManager.do_load()
	if PlayerData.current_level == 0:
		$CenterContainer/VBoxContainer/Play.visible = true
		$CenterContainer/VBoxContainer/Continue.disabled = true
		$CenterContainer/VBoxContainer/LevelSelect.disabled = true
		
	if PlayerData.has_finished_game():
		$CenterContainer/VBoxContainer/Continue.disabled = true
		
	MusicManager.do_play("menu")
	
func _on_Play_pressed():
	AudioPlayer.on_click()
	match PlayerData.current_level:
		0: get_tree().change_scene("res://src/screen_controls/ScreenControls.tscn")
		1: get_tree().change_scene("res://src/levels/Level_1.tscn")
		2: get_tree().change_scene("res://src/levels/Level_2.tscn")
		3: get_tree().change_scene("res://src/levels/Level_3.tscn")
		4: get_tree().change_scene("res://src/levels/Level_4.tscn")
		5: get_tree().change_scene("res://src/levels/Level_5.tscn")

func _on_Level_Select_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_levelselect/ScreenLevelSelect.tscn")

func _on_Options_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_options/ScreenOptions.tscn")

func _on_Exit_pressed():
	AudioPlayer.on_click()
	pass # Replace with function body.

func _on_About_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_credits/ScreenCredits.tscn")
	
""" PUBLIC """
