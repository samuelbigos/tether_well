extends RigidBody2D
class_name RopeSegment
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
	pass

""" PUBLIC """

func set_connected(node):
	$Pin.set_node_a(node.get_path())
	$Pin.set_node_b(self.get_path())

func get_length():
	return $Collision.shape.height
