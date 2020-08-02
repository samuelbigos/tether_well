extends RigidBody2D
class_name Chest
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

signal on_dude_enter(chest)

###########
# METHODS #
###########

""" PRIVATE """

""" PUBLIC """

func _on_Area2D_body_entered(body):
	if body.is_in_group("dude"):
		emit_signal("on_dude_enter", self)
