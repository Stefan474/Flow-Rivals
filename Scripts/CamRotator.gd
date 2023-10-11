extends AnimationPlayer

var turnCounter = 0

func _on_lock_in_lock_move(_arg1, _arg2):
	pass
	


func _on_sound_controller_timeout():
	
	if turnCounter == 0:
		play("smallRotate")
		turnCounter += 1
	else:
		play("rotateCamAnim")
		turnCounter = 0
	
	
