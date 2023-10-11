extends TextEdit


func _on_tooltip_controller_mouse_exited():
	self.visible = false


func _on_lock_in_ammo_notif():
	self.visible = true


func _on_ammo_notif_timer_timeout():
	self.visible = false
