extends StaticBody2D
class_name Platform
tool
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var width = 0 setget set_width
func set_width(val):
	width = val
	_setup()
export var texture_width = 10	
export var stream_texture_l : StreamTexture
export var stream_texture_c : StreamTexture
export var stream_texture_r : StreamTexture  

###########
# METHODS #
###########

""" PRIVATE """

func _init():
	_setup()

func _ready():
	add_to_group("platform")
	_setup()

func _setup():
	for child in get_children():
		if child.is_in_group("coin") or child.is_in_group("spike"):
			continue
		child.queue_free()
		
	var sprite_l = Sprite.new()
	sprite_l.texture = stream_texture_l
	sprite_l.position = Vector2(-texture_width * 0.5 * width, 0.0)
	add_child(sprite_l)
	var sprite_r = Sprite.new()
	sprite_r.texture = stream_texture_r
	sprite_r.position = Vector2(texture_width * 0.5 * width, 0.0)
	add_child(sprite_r)
	
	for i in range(1, width):
		var sprite_c = Sprite.new()
		sprite_c.texture = stream_texture_c
		var pos_x = -(width * 0.5) * texture_width + i * texture_width
		sprite_c.position = Vector2(pos_x, 0.0)
		add_child(sprite_c)
		
	var collision = CollisionShape2D.new()
	var shape = CapsuleShape2D.new()
	shape.radius = texture_width * 0.5
	shape.height = (width) * texture_width
	collision.shape = shape
	collision.rotation_degrees = 90
	add_child(collision)
	
""" PUBLIC """
