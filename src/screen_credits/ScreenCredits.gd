extends CanvasLayer
class_name ScreenCredits
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

var _scroll = 0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$ScrollContainer.set_v_scroll(0)
	if PlayerData.has_finished_game() == true:
		MusicManager.do_play("credits")
		$ScrollContainer/VBoxContainer/GameWon.visible = true
		$ScrollContainer/VBoxContainer/HSeparator2.visible = true
		
func _process(delta):
	_scroll += 8.0 * delta
	$ScrollContainer.set_v_scroll(_scroll)

""" PUBLIC """

func _on_Back_pressed():
	get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")
