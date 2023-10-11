extends Label


signal visibilityOffTimer()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true


func _on_match_countdown_countdown_signal(val):
	print(val)
	match str(val):
		"2": text = "IN"
		"1": text = "THE"
		"FLOW!": text = "FLOW!"
	if str(val) == "FLOW!":
		visibilityOffTimer.emit()


func _on_hide_countdown_timeout():
	self.visible = false
