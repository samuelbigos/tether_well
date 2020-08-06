extends Node2D
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _ftue = [
	"You are a brave and couragous estate owner who has generously given the man-without-a-hat (let's call him Steve) the chance to share in great riches, the only risk being to delve into a well full of untold evils.",
	"Steve is of simple mind, so of course you'll have to do most of the work. You can unwind and rewind the tether by holding [LEFT MOUSE] and tracing a clockwise or anti-clockwise circle. Try this now.",
	"The rope on the left indicates how much is left. Once you run out of rope, you won't be able to unwind any more.",
	"Incredible. Now, Steve will wander aimlessly forward unless you yell at him by pressing [SPACEBAR]. This will cause him to turn around. Give it a try.",
	"You found... uh I mean Steve found some gold! Well done Steve! Gold acts as a shield against damage. Here, make Steve walk into those spikes just ahead.",
	"Your primary goal is to retrieve the chest of 'heirlooms' from the well, and haul it back up. Be warned, this is usually well guarded... Good luck! "
	
]
var _ftue_timer = 2.0
var _showing_ftue = false

""" PUBLIC """

export var level_id = 0
export var wurm_scene : PackedScene

###########
# METHODS #
###########

""" PRIVATE """
	
func _ready():
	$Rope.connect("on_rope_reeled", $RopeLeft, "_on_Rope_on_rope_reeled")
	$Rope._on_Reel_on_reel(0.0)
	PlayerData.coins = 0
	PlayerData.time = 0
	
func _process(delta):
	if _showing_ftue:
		_dismiss_ftue()
	
	PlayerData.time += delta
	$HUD.set_time("%01d:%02d.%01d" % [ int(PlayerData.time / 60), int(PlayerData.time / 1) % 60, int(fmod(PlayerData.time, 1.0) * 10.0) ])
	$HUD.set_score("%d" % [ PlayerData.coins ])
	
	_ftue_timer -= delta
	if _ftue_timer < 0.0 and PlayerData.ftue == 0:
		_do_ftue(PlayerData.ftue)
		_ftue_timer = 1.0
		
	if _ftue_timer < 0.0 and PlayerData.ftue == 1:
		_do_ftue(PlayerData.ftue)
		
	if $Rope.get_percentage() > 0.2 and PlayerData.ftue == 2 and not _showing_ftue:
		_do_ftue(PlayerData.ftue)
		
	if $Rope.get_dude().has_touched_ground() and PlayerData.ftue == 3 and not _showing_ftue:
		_do_ftue(PlayerData.ftue)
		
	if PlayerData.coins > 0 and PlayerData.ftue == 4 and not _showing_ftue:
		_do_ftue(PlayerData.ftue)
		_ftue_timer = 8.0
		
	if _ftue_timer < 0.0 and PlayerData.ftue == 5 and not _showing_ftue:
		_do_ftue(PlayerData.ftue)
	
func _do_ftue(stage):
	if PlayerData.current_level != 1:
		return
	
	$FTUE.get_children()[PlayerData.ftue].set_text(_ftue[PlayerData.ftue])
	get_tree().paused = true
	PlayerData.complete_ftue_stage(PlayerData.ftue)
	_showing_ftue = true
	
func _dismiss_ftue():
	$FTUE.get_children()[PlayerData.ftue - 1].hide()
	_showing_ftue = false
	
func _input(event):
	pass
	
func _on_level_complete():
	PlayerData.complete_level(level_id, PlayerData.coins, PlayerData.time)
	AudioPlayer.on_complete()
	get_tree().change_scene("res://src/screen_levelselect/ScreenLevelSelect.tscn")
	
func _on_chest_pick():
	if $WurmSpawn:
		var wurm = wurm_scene.instance()
		wurm.position = $WurmSpawn.position
		wurm._target = $Rope.get_dude()
		add_child(wurm)
		
func _on_dude_change_dir():
	$HUD.yell()
	
func _on_dude_hurt():
	$HUD.dude_text($Rope.get_dude())
	
""" PUBLIC """

func get_chest():
	return $Chest

func _on_ChestArea_body_entered(body):
	if body.is_in_group("chest"):
		_on_level_complete()
