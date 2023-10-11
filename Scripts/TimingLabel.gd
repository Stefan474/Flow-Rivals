extends Label

signal disappearingLabel()

func _on_kick_sound_nice_beat(beat):
	self.visible = true
	text = str(beat)
	disappearingLabel.emit()


func _on_hide_label_timeout():
	self.visible = false
