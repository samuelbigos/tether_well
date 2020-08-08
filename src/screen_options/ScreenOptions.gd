extends CanvasLayer
class_name ScreenOptions
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

const MUSIC_MAX = 5
const EFFECTS_MAX = 5

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	_update_audio()
		
func _update_audio():
	$CenterContainer/VBoxContainer/Music.text = "Music "
	for i in range(0, PlayerData.get("music")):
		$CenterContainer/VBoxContainer/Music.text += "-"
		
	$CenterContainer/VBoxContainer/Effects.text = "Effects "
	for i in range(0, PlayerData.get("effects")):
		$CenterContainer/VBoxContainer/Effects.text += "-"
		
""" PUBLIC """

func _on_ResetSave_pressed():
	AudioPlayer.on_click()
	PlayerData.reset()
	get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")
	SaveManager.do_save()

func _on_Back_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_menu/ScreenMenu.tscn")

func _on_Controls_pressed():
	AudioPlayer.on_click()
	get_tree().change_scene("res://src/screen_controls/ScreenControls.tscn")

func _on_Music_pressed():
	PlayerData.set("music", (PlayerData.get("music") + 1) % (MUSIC_MAX + 1))
	_update_audio()
	MusicManager.set_volume(PlayerData.get("music"))
	AudioPlayer.on_click()
	SaveManager.do_save()

func _on_Effects_pressed():
	PlayerData.set("effects", (PlayerData.get("effects") + 1) % (EFFECTS_MAX + 1))
	_update_audio()
	AudioPlayer.on_click()
	SaveManager.do_save()
