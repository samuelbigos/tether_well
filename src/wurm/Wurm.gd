extends RigidBody2D
class_name Wurm
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _target = null
var _spawn_pos = Vector2()
var _segments = []
var _rand_dir = Vector2()
var _noise = OpenSimplexNoise.new()

""" PUBLIC """

const MOVE_SPEED = 20.0
const SEGMENT_LENGTH = 14
const RAND_MOVE_INFLUENCE = 2.0

export var segment_scene : PackedScene

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	_spawn_pos = position
	_segments.append(self)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	_noise.seed = rng.randi()
	_noise.octaves = 1
	_noise.lacunarity = 3.0
	_noise.period = 50.0
	_noise.persistence = 0.8

func _integrate_forces(state):
	if _target:
		var target_vector = _target.global_position - global_position
		var move_dir = target_vector.normalized() 
		var rand_adjust = Vector2(move_dir.y, -move_dir.x) * _noise.get_noise_2d(global_position.x, global_position.y)
		move_dir += rand_adjust * RAND_MOVE_INFLUENCE
		print(rand_adjust)
		state.linear_velocity = move_dir * MOVE_SPEED
		var transform = Transform(state.transform)	
		state.transform = Transform2D(atan2(move_dir.x, -move_dir.y), state.transform.get_origin())
		state.angular_velocity = 0.0
		
	if (_spawn_pos - _segments[_segments.size() - 1].position).length() > SEGMENT_LENGTH:
		var segment = segment_scene.instance()
		segment.position = _spawn_pos
		segment.rotation = _segments[_segments.size() - 1].rotation
		get_parent().add_child(segment)
		segment.setup(_segments[_segments.size() - 1])
		_segments.append(segment)

""" PUBLIC """
