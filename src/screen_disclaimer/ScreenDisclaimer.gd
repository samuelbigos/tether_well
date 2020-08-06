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

func _input(event):
	if event.is_action_pressed("ui_next"):
		get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")

""" PUBLIC """

