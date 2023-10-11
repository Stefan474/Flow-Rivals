extends Timer

signal restartTexture()

func _on_enemy_card_start_timer():
	start(3)


func _on_lock_in_stop_card_change_timer():
	stop()
	restartTexture.emit()
