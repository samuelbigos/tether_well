extends Sprite
class_name Reel
"""
Does XXX.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _mouse_start = Vector2()
var _prev_angle = 0.0

""" PUBLIC """

signal on_reel(delta)

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	if Input.is_action_just_pressed("game_unwind"):
		visible = true
		position = get_global_mouse_position()
		_mouse_start = get_global_mouse_position()
		
	if Input.is_action_just_released("game_unwind"):
		visible = false
		
	if Input.is_action_pressed("game_unwind"):
		var current_mouse = get_global_mouse_position()
		var vec = _mouse_start - current_mouse
		var current_angle = atan2(vec.x, vec.y)
		rotation = -current_angle - (PI / 4)
		var angle_delta = current_angle - _prev_angle
		if abs(angle_delta) < PI:
			emit_signal("on_reel", angle_delta)
		_prev_angle = current_angle

""" PUBLIC """