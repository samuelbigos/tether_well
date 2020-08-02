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
var _invincibility_timer = 0.0
var _flash_timer = 0.0
var _flashing = false

var coin_res = preload("res://src/env/Coin.tscn")
	
""" PUBLIC """

const MOVE_SPEED = 25
const INVINCIBILITY_TIME = 2.5
const INV_FLASH_TIME = 0.05
const COIN_DROP_IMPULSE = 200.0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$AnimSprite.play("fall")
	
func _process(delta):
	_invincibility_timer -= delta
	if _invincibility_timer < 0.0:
		_flashing = false
		$AnimSprite.visible = true
	if _flashing:
		_flash_timer -= delta
		if _flash_timer < 0.0:
			$AnimSprite.visible = !$AnimSprite.visible
			_flash_timer = INV_FLASH_TIME

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
	
func _is_invincible():
	return _invincibility_timer > 0.0
	
func _drop_coins():
	var coin_count = PlayerData._coins
	PlayerData._coins = 0
	var angle_min = 0.5
	var angle_max = PI - 0.5
	for i in coin_count:
		var angle = angle_min + ((angle_max - angle_min) / coin_count) * (i + 0.5)
		var coin = coin_res.instance()
		var impulse = Vector2(cos(angle), -sin(angle)).normalized() * COIN_DROP_IMPULSE
		coin.apply_impulse(Vector2(0.0, 0.0), impulse)
		coin.set_was_dropped()
		get_parent().add_child(coin)
		coin.position = Vector2(position.x, position.y - $Collision.shape.height)

""" PUBLIC """

func set_connected(node):
	$Pin.set_node_a(node.get_path())
	$Pin.set_node_b(self.get_path())

func get_length():
	return $Collision.shape.height

func on_hit(hitter):
	if _is_invincible():
		return
		
	if PlayerData._coins > 0:	
		_invincibility_timer = INVINCIBILITY_TIME
		_flashing = true
		_flash_timer = INV_FLASH_TIME
		_drop_coins()
	else:
		pass
		#end_game
