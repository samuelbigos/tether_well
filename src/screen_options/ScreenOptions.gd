extends CanvasLayer
class_name ScreenOptions
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
	pass
	
""" PUBLIC """

func _on_ResetSave_pressed():
	AudioPlayer.on_click()
	PlayerData.reset()
	get_tree().change_scene("res://src/screen_disclaimer/ScreenDisclaimer.tscn")
	SaveManager.do_save()

func _on_Back_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")

func _on_Controls_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_controls/ScreenControls.tscn")
