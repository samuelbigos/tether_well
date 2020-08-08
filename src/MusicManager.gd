extends Node
"""
Singleton that handles playing music.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _playing = null
var _track = ""
var _volumes = [
	-100,
	-25,
	-20,
	-15,
	-10,
	-5
]

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass
		
func _on_track_finished():
	pass
	
""" PUBLIC """

func set_volume(val):
	_playing.volume_db = _volumes[val]

func is_playing():
	return _playing != null
	
func do_play(track):
	if _track == track:
		return
		
	if _playing:
		_playing.stop()
		
	match track:
		"menu":
			_playing = $MenuMusic
		"intro":
			_playing = $LevelTracks/Intro
		"1":
			_playing = $LevelTracks/Level1
		"2":
			_playing = $LevelTracks/Level2
		"3":
			_playing = $LevelTracks/Level3
		"4":
			_playing = $LevelTracks/Level4
		"5":
			_playing = $LevelTracks/Level5
		"credits":
			_playing = $Credits
		
	_track = track	
	_playing.connect("finished", self, "_on_track_finished")
	_playing.volume_db = _volumes[PlayerData.get("music")]
	_playing.play()
