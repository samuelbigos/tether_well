extends Node
class_name RopeLeft
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
	var segment_length = 8
	var height = $End.position.y
	var rope_texture = load("res://assets/items/rope.png")
	var y = 0
	while y < height:
		var segment = Sprite.new()
		segment.texture = rope_texture
		segment.position = Vector2(0.0, y)
		y += segment_length
		add_child(segment)

""" PUBLIC """

func _on_Rope_on_rope_reeled(percentage):
	$Cover.position.y = (1.0 - percentage) * $End.position.y
