extends Node
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _did_press = false

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _process(delta):
	pass
	#if get_tree().paused and Input.is_action_just_pressed("ui_next"):
	#	_did_press = true
	
func _input(event):
	pass
	#if event.is_action_released("ui_next") and get_tree().paused and _did_press:
	#	get_tree().paused = false
	#	_did_press = false
		
""" PUBLIC """
