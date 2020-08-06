extends CanvasLayer
class_name ScreenLevelSelect
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var levels = [
	{
		"title": "Intro",
		"scene": "res://src/screen_intro/ScreenIntro.tscn"
	},
	{
		"title": "Level 1",
		"scene": "res://src/levels/Level_1.tscn"
	},
	{
		"title": "Level 2",
		"scene": "res://src/levels/Level_2.tscn"
	},
	{
		"title": "Level 3",
		"scene": "res://src/levels/Level_3.tscn"
	},
	{
		"title": "Level 4",
		"scene": "res://src/levels/Level_4.tscn"
	},
	{
		"title": "Level 5",
		"scene": "res://src/levels/Level_5.tscn"
	},
]

""" PUBLIC """

export var level_widget_scene : PackedScene

###########
# METHODS #
###########6

""" PRIVATE """

func _ready():
	for i in range(0, levels.size()):
		var widget = level_widget_scene.instance()
		widget.title = levels[i]["title"]
		if i > PlayerData.current_level:
			widget.set_disabled()
		else:
			if PlayerData.has_level_record(i) and i != 0:
				var record = PlayerData.get_level_record(i)			
				widget.score = "%d" % record["score"]
				widget.time = "%01d:%02d.%01d" % [ int(record["time"] / 60), int(record["time"] / 1) % 60, int(fmod(record["time"], 1.0) * 10.0) ]
			else:
				widget.score = "-"
				widget.time = "-"
			widget.level_path = levels[i]["scene"]
			
		$CenterContainer/GridContainer.add_child(widget)
		
		if PlayerData.current_level == i:
			widget.set_current()

""" PUBLIC """

