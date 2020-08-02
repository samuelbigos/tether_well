extends Node2D
class_name Rope
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _rope_segments = []
var _unwinding = false
var _rewinding = false

""" PUBLIC """

export var rope_segment_scene : PackedScene = null
export var dude_scene : PackedScene = null
export var rope_segments = 100
export var unwind_speed = 50
export var rewind_speed = 50

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var prev_segment = null
	for i in range(0, rope_segments):
		var segment = rope_segment_scene.instance()
		segment.position.y += segment.get_length() * (i + 1)
		add_child(segment)
		if prev_segment == null:
			segment.set_connected($Anchor)
		else:
			segment.set_connected(prev_segment)
		_rope_segments.append(segment)
		prev_segment = segment
		
	var dude = dude_scene.instance()
	var end_rope = _rope_segments[_rope_segments.size() - 1]
	dude.position.y = end_rope.position.y + 5
	add_child(dude)
	dude.set_connected(end_rope)
	get_parent().get_chest().connect("on_dude_enter", dude, "_on_chest_pick")
	
func _physics_process(delta):
	if Input.is_action_pressed("game_unwind"):
		$Anchor.position.y += unwind_speed * delta
	
	if Input.is_action_pressed("game_rewind"):
		$Anchor.position.y -= rewind_speed * delta
	
""" PUBLIC """

func set_unwinding(unwinding):
	_unwinding = unwinding
	
func set_rewinding(rewinding):
	_rewinding = rewinding
