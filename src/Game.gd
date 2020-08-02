extends Node2D
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _score = 0
var _time = 0

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	for coin in get_tree().get_nodes_in_group("coin"):
		coin.connect("on_picked", self, "on_Coin_on_picked")
	
func _process(delta):
	_time += delta
	$CanvasLayer/TimeLabel.text = "%01d:%02d.%01d" % [ int(_time / 60), int(_time / 1) % 60, int(fmod(_time, 1.0) * 10.0) ]
	
func _input(event):
	pass
	
func on_Coin_on_picked(coin):
	coin.queue_free()
	_score += 1
	$CanvasLayer/ScoreLabel.text = "%d" % [ _score ]	

""" PUBLIC """

func get_chest():
	return $Chest
