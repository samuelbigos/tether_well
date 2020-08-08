extends Node2D
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

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

""" PUBLIC """

func on_click():
	$ButtonClick.volume_db = _volumes[PlayerData.get("effects")]
	$ButtonClick.play()
	
func on_hit():
	$Hit.volume_db = _volumes[PlayerData.get("effects")]
	$Hit.play()
	
func on_coin():
	$Coin.volume_db = _volumes[PlayerData.get("effects")]
	$Coin.play()

func on_complete():
	$Complete.volume_db = _volumes[PlayerData.get("effects")]
	$Complete.play()

func on_wurm():
	$Wurm.volume_db = _volumes[PlayerData.get("effects")]
	$Wurm.play()
