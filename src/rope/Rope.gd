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
var _dude = null

""" PUBLIC """

signal on_rope_reeled(percentage)

export var rope_segment_scene : PackedScene = null
export var dude_scene : PackedScene = null
export var rope_segments = 100
export var wind_speed = 2.5
export var in_intro = false

const ROPE_Y_MIN = -50
const ROPE_Y_MAX = 450

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
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
	
	if not in_intro:
		_dude = dude_scene.instance()
		var end_rope = _rope_segments[_rope_segments.size() - 1]
		_dude.position.y = end_rope.position.y + 5
		add_child(_dude)
		_dude.set_connected(end_rope)
		get_parent().get_chest().connect("on_dude_enter", _dude, "_on_chest_pick")
		_dude.connect("on_chest_pick", get_parent(), "_on_chest_pick")
		_dude.connect("on_change_dir", get_parent(), "_on_dude_change_dir")
		_dude.connect("on_hurt", get_parent(), "_on_dude_hurt")
		_dude.connect("on_game_over", get_parent(), "_on_game_over")
	else:
		for i in _rope_segments.size():
			_rope_segments[i].gravity_scale = 0.5
			_rope_segments[i].apply_central_impulse(Vector2(i * rng.randf_range(0.2, 0.3), 0.0))			
	
func _physics_process(delta):
	pass
	
func _on_Reel_on_reel(delta):
	$Anchor.position.y = min(ROPE_Y_MAX, max(ROPE_Y_MIN, $Anchor.position.y - wind_speed * delta))
	var y = $Anchor.position.y
	var percentage = (y - ROPE_Y_MIN) / (ROPE_Y_MAX - ROPE_Y_MIN)
	emit_signal("on_rope_reeled", percentage)
	
""" PUBLIC """

func set_unwinding(unwinding):
	_unwinding = unwinding
	
func set_rewinding(rewinding):
	_rewinding = rewinding
	
func get_percentage():
	var y = $Anchor.position.y
	var percentage = (y - ROPE_Y_MIN) / (ROPE_Y_MAX - ROPE_Y_MIN)
	return percentage

func get_dude():
	return _dude
