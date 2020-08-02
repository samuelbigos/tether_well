extends Area2D
class_name Coin
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

signal on_picked(coin)

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	position.y = -16

""" PUBLIC """

func _on_Coin_body_entered(body):
	if body.is_in_group("dude"):
		emit_signal("on_picked", self)
