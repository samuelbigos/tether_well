extends Node
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _SAVE_KEY = "player_data"
var _data = {}

""" PUBLIC """

var coins = 0 setget set_coins, get_coins
func set_coins(val): _data["coins"] = val
func get_coins(): return _data["coins"]

var current_level = 0 setget set_current_level, get_current_level
func set_current_level(val): _data["current_level"] = val
func get_current_level(): return _data["current_level"]

var time = 0 setget set_time, get_time
func set_time(val): _data["time"] = val
func get_time(): return _data["time"]

###########
# METHODS #
###########

""" PRIVATE """

func _init():
	add_to_group("persistent")
	_do_create_new()
	
func _do_create_new():
	_data["current_level"] = 0
	_data["coins"] = 0
	_data["time"] = 0	
	
""" PUBLIC """

func reset():
	_do_create_new()
	
func do_save():
	var save_data = {}
	
	# save misc data
	save_data["data"] = _data.duplicate(true)
	return save_data
	
func do_load(save_data : Dictionary):
	_do_create_new()
	_data = save_data["data"].duplicate(true)
