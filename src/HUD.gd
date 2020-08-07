extends CanvasLayer
class_name HUD
"""
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _yell_timer = 0.0
var _dude_text_timer = 0.0
var _dude = null
var _rng = RandomNumberGenerator.new()
var _dead = false

""" PUBLIC """

const YELL_SHOW_TIME = 1.0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	_rng.randomize()

func _process(delta):
	_yell_timer -= delta
	if _yell_timer < 0.0:
		$Yell.hide()
		
	_dude_text_timer -= delta
	if _dude_text_timer < 0.0:
		$DudeText.hide()
	else:
		$DudeText.rect_position = _dude.global_position - $DudeText.rect_size * 0.5 - Vector2(0.0, 35.0)

func _input(event):
	if _dead and event.is_action_pressed("ui_next"):
		get_tree().reload_current_scene()

""" PUBLIC """

func set_time(time):
	$TimeLabel.text = time

func set_score(score):
	$ScoreLabel.text = score
	
func yell():
	_yell_timer = YELL_SHOW_TIME
	$Yell.rect_position.x = _rng.randf_range(150.0, 250.0)
	match _rng.randi_range(0, 2):
		0:
			$Yell.set_text("OTHER WAY!", true)
		1:
			$Yell.set_text("TURN AROUND!", true)
		2:
			$Yell.set_text("NOT THERE!", true)
			
func dude_text(target):
	_dude_text_timer = YELL_SHOW_TIME
	_dude = target
	$DudeText.rect_position = _dude.global_position - $DudeText.rect_size * 0.5 - Vector2(0.0, 35.0)
	match _rng.randi_range(0, 3):
		0:
			$DudeText.set_text("Oof! Ouch!", true)
		1:
			$DudeText.set_text("Sir that hurt!", true)
		2:
			$DudeText.set_text("I stubbed my toe", true)
		3:
			$DudeText.set_text("Why...", true)
			
func dead():
	get_tree().paused = true
	$DeadPopup.set_text("Steve died :(\nOh well! Click to find a new Steve.")
	_dead = true
