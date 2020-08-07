extends CanvasLayer
class_name ScreenDisclaimer
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

func _input(event):
	if event.is_action_pressed("ui_next"):
		AudioPlayer.on_click()
		if PlayerData.control_method == -1:
			get_tree().change_scene("res://src/screen_controls/ScreenControls.tscn")
		else:
			get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")

""" PUBLIC """

