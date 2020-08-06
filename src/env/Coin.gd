extends RigidBody2D
class_name Coin
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _collection_delay = 0.0
var _collection_timer = 0.0
var _was_droppped = false
var _flash_timer = 0.0

""" PUBLIC """

const TIME_TO_COLLECT = 5.0
const FLASH_TIME_1 = 0.1
const FLASH_TIME_2 = 0.2

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	position.y = -16
	connect("body_entered", self, "_on_Coin_body_entered")
	
func _process(delta):
	_collection_delay -= delta
	if _was_droppped:		
		_collection_timer -= delta
		_flash_timer -= delta
		if _collection_timer <= 0.0:
			queue_free()
		if _flash_timer < 0.0:
			$AnimatedSprite.visible = !$AnimatedSprite.visible
			if _collection_timer < TIME_TO_COLLECT * 0.5:
				_flash_timer = FLASH_TIME_1
			else:
				_flash_timer = FLASH_TIME_2
				
func _can_collect():
	return _collection_delay <= 0.0
	
func _integrate_forces(state):
	var up = Vector2(0.0, -1.0)
	var transform = Transform(state.transform)	
	state.transform = Transform2D(atan2(up.x, -up.y), state.transform.get_origin())
	state.angular_velocity = 0.0

func _on_Coin_body_entered(body):
	if body.is_in_group("dude") and _can_collect():
		AudioPlayer.on_coin()
		self.queue_free()
		PlayerData.coins += 1
		
""" PUBLIC """

func set_was_dropped():
	_was_droppped = true
	_collection_timer = TIME_TO_COLLECT
	_flash_timer = FLASH_TIME_2
	_collection_delay = 0.25
