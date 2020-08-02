extends RigidBody2D
class_name WurmSegment
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _parent_segment = null

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass

func _integrate_forces(state):
	pass

""" PUBLIC """

func setup(parent):
	_parent_segment = parent
	$Pin.node_a = get_path()
	$Pin.node_b = parent.get_path()
