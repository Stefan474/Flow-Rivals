extends Timer

signal clapOrKick()
signal blockerReset()
signal screenShake()
signal beatVisualizerPace() #changes how fast the beat visualizer movces 
signal comboUp() #governs combo
signal comboReset() #resets combo counter
signal sendSpeed()

@onready var miss = $kick_sound/kick_miss
@onready var hit = $kick_sound/kick_hit
@onready var kick_sound = $kick_sound
@onready var speedController = $MatchCountdown
@onready var beatAnimationPlayer = $BeatAnimation/PulsePlayer
@onready var OSTplayer = $kick_sound/OSTactive

var playingOST = false

var inputBlocker = 0
var speed = 1 
var windowModifier = 0.065

func _ready():
	speed = speedCalc()

func _on_lock_in_stop_music():
	stop()
	beatAnimationPlayer.speed_scale = 0

func speedCalc():
	if Global.p1Lives == 1 || Global.p2Lives == 1:
		return 0.5
	elif Global.p1Lives <= 2 || Global.p2Lives <= 2:
		return 0.666
	else:
		return 0.8

func _on_lock_in_check_timing_kick(val):
	if kick_sound.visibleCount != 2:
		miss.play()
		comboReset.emit()
		return
	if inputBlocker == 1:
		miss.play()
		comboReset.emit()
		return 
	if time_left >= speed-windowModifier || time_left <= windowModifier+0.02:
		clapOrKick.emit(val)
		hit.play()
		screenShake.emit()
	else:
		inputBlocker = 1
		miss.play()
		comboReset.emit()
		blockerReset.emit(0.5)
	


func _on_match_countdown_start_game():
	start(speed)


func _on_input_block_timer_timeout():
	inputBlocker = 0


func _on_match_countdown_get_speed():
	speedController = $MatchCountdown
	speed = speedCalc()
	speedController.start(speed)
	beatVisualizerPace.emit(speed)
	sendSpeed.emit(speed)
	beatAnimationPlayer = $BeatAnimation/PulsePlayer
	beatAnimationPlayer.play("BeatPulse")
	match speed:
		0.8:
			beatAnimationPlayer.speed_scale = 1.25
		0.666:
			beatAnimationPlayer.speed_scale = 1.5
		0.5:
			beatAnimationPlayer.speed_scale = 2

func _on_kick_sound_combo_up():
	comboUp.emit()
	


func _on_kick_sound_combo_reset():
	comboReset.emit()
	
func timeout():
	print("timeout test vibes")


func _on_lock_in_reset_combo():
	comboReset.emit()
