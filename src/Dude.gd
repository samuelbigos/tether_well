extends RigidBody2D
class_name Dude
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _attached_body = null
var _last_attached_body = null
var _move_dir = Vector2(1.0, 0.0)

""" PUBLIC """

const MOVE_SPEED = 25

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$AnimSprite.play("fall")

func _input(event):
	if event.is_action_pressed("ui_select"):
		_move_dir *= Vector2(-1.0, 0.0)
		if _move_dir.x > 0:
			$AnimSprite.flip_h = false
		else:
			$AnimSprite.flip_h = true

func _integrate_forces(state):
	var up = Vector2(0.0, -1.0)
	var transform = Transform(state.transform)
	
	state.transform = Transform2D(atan2(up.x, -up.y), state.transform.get_origin())
	state.angular_velocity = 0.0
	
	if _attached_body:
		state.linear_velocity = _move_dir * MOVE_SPEED
			
func _on_Dude_body_entered(body):
	if body.is_in_group("platform") and body.get_global_position().y > get_global_position().y:
		_attached_body = body
		_last_attached_body = body
		$AnimSprite.play("walk")
		
	#if body.is_in_group("chest"):
	#	var joint = PinJoint2D.new()
	#	joint.set_node_a(self.get_path())
	#	joint.set_node_b(body.get_path())
	#	add_child(joint)

func _on_Dude_body_exited(body):
	if body.is_in_group("platform"):
		_attached_body = null
		$AnimSprite.play("fall")
		
func _on_chest_pick(chest):
	var joint = PinJoint2D.new()
	joint.softness = 0.5
	joint.bias = 0.5
	joint.set_node_a(self.get_path())
	joint.set_node_b(chest.get_path())
	add_child(joint)

""" PUBLIC """

func set_connected(node):
	$Pin.set_node_a(node.get_path())
	$Pin.set_node_b(self.get_path())

func get_length():
	return $Collision.shape.height
	
func spike_hit(spike):
	
