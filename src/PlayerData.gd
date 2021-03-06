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

var current_level = 0 setget , get_current_level
func get_current_level(): return _data["current_level"]

var time = 0 setget set_time, get_time
func set_time(val): _data["time"] = val
func get_time(): return _data["time"]

var ftue = 0 setget , get_ftue
func get_ftue(): return _data["ftue_stage"]

var control_method = 0 setget set_control_method, get_control_method
func set_control_method(val): _data["control_method"] = val
func get_control_method(): 
	if _data.has("control_method"): return _data["control_method"]
	else: return -1

###########
# METHODS #
###########

""" PRIVATE """

func _init():
	add_to_group("persistent")
	_do_create_new()
	
func _do_create_new():
	_data["current_level"] = 0
	_data["level_record"] = {}
	_data["coins"] = 0
	_data["time"] = 0
	_data["ftue_stage"] = 0
	_data["control_method"] = -1
	_data["music"] = 5
	_data["effects"] = 5
	
""" PUBLIC """

func reset():
	_do_create_new()
	
func set(key, val):
	if _data.has(key):
		_data[key] = val
		
func get(key):
	if _data.has(key):
		return _data[key]
	
func complete_level(level, score, time):
	if _data["current_level"] == level:
		_data["current_level"] += 1
		
	if not _data["level_record"].has(level):
		_data["level_record"][level] = {}
		_data["level_record"][level]["score"] = 0
		_data["level_record"][level]["time"] = 9999999
		
	var record = _data["level_record"][level]
	record["score"] = max(record["score"], score)
	record["time"] = min(record["time"], time)
	_data["level_record"][level] = record
	
	SaveManager.do_save()
	
func has_finished_game():
	return _data["current_level"] >= 6
		
func has_level_record(level_id):
	return _data["level_record"].has(level_id)
		
func get_level_record(level_id):
	return _data["level_record"][level_id]
	
func complete_ftue_stage(id):
	if _data["ftue_stage"] == id:
		_data["ftue_stage"] += 1
	
func do_save():
	var save_data = {}
	
	# save misc data
	save_data["data"] = _data.duplicate(true)
	return save_data
	
func do_load(save_data : Dictionary):
	_do_create_new()
	_data = save_data["data"].duplicate(true)
