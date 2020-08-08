extends Node2D
class_name ScreenIntro
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _dialogue = [
	{
		"speaker": 0,
		"text": "You, man, over there!"
	},{
		"speaker": 1,
		"text": "Huh, what?"
	},{
		"speaker": 0,
		"text": "I need you to descend this well and retrieve my long lost family heirlooms."
	},{
		"speaker": 1,
		"text": "Who are you?"
	},{
		"speaker": 0,
		"text": "I'm the owner of this estate."
	},{
		"speaker": 1,
		"text": "But, this well is in the middle of barren swampland."
	},{
		"speaker": 0,
		"text": "Yes, the evil that resides in this well brought about my family's downfall over multiple generations."
	},{
		"speaker": 0,
		"text": "I am all that remains. Oh how I miss them so, etc. "
	},{
		"speaker": 1,
		"text": "Why would I trust you?"
	},{
		"speaker": 0,
		"text": "I have a hat."
	},{
		"speaker": 1,
		"text": "Oh, OK."
	},{
		"speaker": 0,
		"text": "Look, we must hurry. Quick, attach yourself to this tether."
	},{
		"speaker": 1,
		"text": "Why are we both walking on the spot?"
	},{
		"speaker": 0,
		"text": "Our creator didn't have time to give us idle animations only for this intro."
	},{
		"speaker": 1,
		"text": "Creator? Intro? What are you talking."
	},{
		"speaker": 0,
		"text": "That's not important right now."
	},{
		"speaker": 0,
		"text": "What matters is plundering the treasure I mean retrieving my family's long lost heirlooms."
	},{
		"speaker": 1,
		"text": "Yes... sir."
	}
]

""" PUBLIC """

var _dialogue_tracker = 0
var _queue_dialogue = false

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var walk_speed = 50
	var interp_time = abs($SirTarget.position.x - $Sir.position.x) / walk_speed
	$Sir/Tween.interpolate_property($Sir, "position",
		$Sir.position, $SirTarget.position, interp_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Sir/Tween.start()
	$Sir/Tween.connect("tween_all_completed", self, "_tween_complete")
	
	interp_time = abs($DudeTarget.position.x - $Dude.position.x) / walk_speed
	$Dude/Tween.interpolate_property($Dude, "position",
		$Dude.position, $DudeTarget.position, interp_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Dude/Tween.start()
	
	$CanvasLayer/SirSpeech.visible = false
	$CanvasLayer/DudeSpeech.visible = false
	
	$CanvasLayer/SirSpeech.connect("on_dismissed", self, "_on_SpeechBubble_on_dismissed")
	$CanvasLayer/DudeSpeech.connect("on_dismissed", self, "_on_SpeechBubble_on_dismissed")
	
	MusicManager.do_play("intro")
	
func _process(delta):
	if _queue_dialogue:
		_setup_dialogue()
		_queue_dialogue = false
			
func _intro_complete():
	get_tree().change_scene("res://src/levels/Level_1.tscn")
	PlayerData.complete_level(0, 0, 0)
	SaveManager.do_save()

func _tween_complete():
	_queue_dialogue = true
	
func _setup_dialogue():
	match _dialogue[_dialogue_tracker].speaker:
		0:
			$CanvasLayer/SirSpeech.set_text(_dialogue[_dialogue_tracker].text)
			$CanvasLayer/DudeSpeech.visible = false
		1:
			$CanvasLayer/DudeSpeech.set_text(_dialogue[_dialogue_tracker].text)
			$CanvasLayer/SirSpeech.visible = false
	_dialogue_tracker += 1

func _on_SpeechBubble_on_dismissed():
	if _dialogue_tracker >= _dialogue.size():
		_intro_complete()
	else:
		_queue_dialogue = true
	
""" PUBLIC """


