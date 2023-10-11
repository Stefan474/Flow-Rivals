extends AudioStreamPlayer2D

signal autoLock()

func _on_kick_sound_clap():
	play()
	autoLock.emit()
