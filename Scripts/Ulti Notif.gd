extends TextEdit


func _on_ultimate_ammo_tooltip():
	self.visible = true

func _on_tooltip_controller_ult_mouse_exited():
	self.visible = false

func _on_ulti_notif_timer_timeout():
	self.visible = false
