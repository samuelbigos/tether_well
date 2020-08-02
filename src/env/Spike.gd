extends Area2D
class_name Spike
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

const SPIKE_FREQUENCY = 5.0

enum State {
	idle,
	tell,
	extend,
}

var _state = State.idle
var _timer = 0.0

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	position.y = -18
	_timer = SPIKE_FREQUENCY
	$AnimatedSprite.connect("animation_finished", self, "_anim_finished")
	
func _process(delta):
	match _state:
		State.idle:
			_timer -= delta
			if _timer < 0.0:
				_change_state(State.tell)
				_timer = SPIKE_FREQUENCY
		State.tell:
			pass
		State.extend:
			for body in get_overlapping_bodies():
				if body.is_in_group("dude"):
					body.on_hit(self)
		
func _change_state(to):
	_state = to
	match _state:
		State.idle:
			$AnimatedSprite.play("idle")
		State.tell:
			$AnimatedSprite.play("tell")
		State.extend:
			$AnimatedSprite.play("extend")
			
func _anim_finished():
	match _state:
		State.tell:
			_change_state(State.extend)
		State.extend:
			_change_state(State.idle)

""" PUBLIC """
