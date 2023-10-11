extends AudioStreamPlayer2D

var count = 0
var visibleCount = 0
var cardChecker = 0 

@onready var hit_sound = $kick_hit
@onready var miss_sound = $kick_miss

signal checkLockedCard()
signal clap()
signal niceBeat()
signal changeCount()
signal comboUp()
signal comboReset()

func _on_sound_controller_timeout():
	if count == 0:
		play()
		changeCount.emit()
	else:
		clap.emit()
		changeCount.emit()

func _on_sound_controller_clap_or_kick(val):
	if visibleCount != 2:
		return
	if count == 0 && val == "kick":
		niceBeat.emit("NICE")
		hit_sound.play()
		cardChecker = 1
		comboUp.emit()
	elif count !=0 && val == "clap":
		niceBeat.emit("BEAT")
		hit_sound.play()
		comboUp.emit()
	else:
		comboReset.emit()
	


func _on_count_changer_timeout():
	if count==0:
		count = 1
	else: count = 0


func _on_lock_in_checktiming_clap():
	if count == 1: 
		niceBeat.emit("BEAT")
	else:
		pass


func _on_match_countdown_play_kick():
	play()


func _on_countdown_label_visibility_changed():
	if visibleCount == 0:
		#play()
		pass
	visibleCount +=1
