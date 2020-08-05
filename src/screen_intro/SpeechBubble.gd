extends NinePatchRect
class_name SpeechBubble
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _text = ""
var _type_timer = 0.0
var _text_index = 0
var _complete = false
var _blink_count = 0
var _blink_timer = 0.0
var _is_yell = false

""" PUBLIC """

signal text_complete

export var char_time = 0.045
export var blink_time = 0.2

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$VBoxContainer/Text.text = ""
	_complete = true
	
func _input(event):
	if not visible:
		return
		
	if _is_yell:
		return
		
	if event.is_action_pressed("ui_next") and _complete and get_tree().paused:
		get_tree().paused = false
		
	elif event.is_action_pressed("ui_next"):
		if not _complete:
			_complete = true
			$VBoxContainer/Text.text = _text
			emit_signal("text_complete")	
	
func _process(delta):
	if _complete and _text.length() > 0 and not _is_yell:
		if _blink_timer < 0.0:
			$VBoxContainer/Text.text += "."
			_blink_count += 1
			if _blink_count == 3:
				_blink_count = 0
				$VBoxContainer/Text.text = _text
			_blink_timer = blink_time
		_blink_timer -= delta
	
	if not _complete:		
		_type_timer -= delta
		if _type_timer < 0.0:
			$VBoxContainer/Text.text += _text[_text_index]
			_text_index += 1
			if _text_index >= _text.length():
				emit_signal("text_complete")
				_complete = true
			else:
				_type_timer = char_time
		
""" PUBLIC """

func set_text(text, is_yell = false):
	visible = true
	_text = text
	_type_timer = char_time
	$VBoxContainer/Text.text = ""
	_complete = false
	_text_index = 0
	_is_yell = is_yell

func hide():
	visible = false
	$VBoxContainer/Text.text = ""
	_complete = true
