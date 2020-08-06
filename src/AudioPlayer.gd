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

""" PUBLIC """

func on_click():
	$ButtonClick.play()
	
func on_hit():
	$Hit.play()
	
func on_coin():
	$Coin.play()

func on_complete():
	$Complete.play()

func on_wurm():
	$Wurm.play()
