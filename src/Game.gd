extends Node2D
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
	$Wurm._target = $Rope.get_dude()
	
func _process(delta):
	PlayerData._time += delta
	$CanvasLayer/TimeLabel.text = "%01d:%02d.%01d" % [ int(PlayerData._time / 60), int(PlayerData._time / 1) % 60, int(fmod(PlayerData._time, 1.0) * 10.0) ]
	$CanvasLayer/ScoreLabel.text = "%d" % [ PlayerData._coins ]	
	
func _input(event):
	pass
	
""" PUBLIC """

func get_chest():
	return $Chest
