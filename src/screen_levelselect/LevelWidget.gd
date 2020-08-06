extends MarginContainer
class_name LevelWidget
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

var title = "" setget set_title
func set_title(val): $NineRect/MarginContainer/VBoxContainer/Title.text = val
var score = "" setget set_score
func set_score(val): 
	$NineRect/MarginContainer/VBoxContainer/HBoxContainer2/Score.text = val
	$NineRect/MarginContainer/VBoxContainer/HBoxContainer2.visible = true
var time = "" setget set_time
func set_time(val): 
	$NineRect/MarginContainer/VBoxContainer/HBoxContainer/Time.text = val
	$NineRect/MarginContainer/VBoxContainer/HBoxContainer.visible = true

var active = true
var level_path = ""
var current = false

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	if active:
		$NineRect.modulate = Color("eff9d6")
	
func _input(event):
	if active:
		var rect = Rect2(rect_global_position, rect_size)
		if event.is_action_pressed("ui_next") and rect.has_point(get_global_mouse_position()):
			get_tree().change_scene(level_path)
			AudioPlayer.on_click()

func _on_NineRect_mouse_entered():
	if active:
		$NineRect.modulate = Color("ba5044")

func _on_NineRect_mouse_exited():
	if active:
		$NineRect.modulate = Color("eff9d6")
		
""" PUBLIC """

func set_disabled():
	$NineRect.modulate = Color("7a1c4b")
	active = false
	
func set_current():
	current = true
	$Tween.interpolate_property($NineRect, "rect_position", $NineRect.rect_position, $NineRect.rect_position + Vector2(0, -2), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.repeat = true
	$Tween.start()
