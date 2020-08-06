extends Area2D
class_name JumpPad
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

enum State {
	idle,
	jump,
}

var _state = State.idle

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	position.y = -18
	$AnimatedSprite.connect("animation_finished", self, "_anim_finished")
	
func _process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("dude") and _state == State.idle:
			body.on_jump()
			$AnimatedSprite.play("jump")
			$AnimatedSprite.frame = 0
			_state = State.jump
			
		
func _anim_finished():
	$AnimatedSprite.stop()
	_state = State.idle

""" PUBLIC """
