extends Timer

var countdown = 3

signal countdownSignal()
signal playKick()
signal startGame()
signal getSpeed()
signal startOst
var speed
var playing = false

func _ready():
	getSpeed.emit()
	

func _on_timeout():
	if countdown == 0:
		stop()
		startGame.emit()
		countdownSignal.emit("FLOW!")
		playKick.emit()
		
	else:
		countdownSignal.emit(countdown)
		playKick.emit()
		if playing == false:
			startOst.emit()
			playing = true
		countdown -=1
