extends Label


signal showButtons()
signal nextRound()

@onready var reloadTimer = $reloadTimer

func _on_lock_in_player_1_win():
	
	Global.p2Lives -= 1
	if Global.p2Lives != 0:
		text = "Round won!\n Get ready..."
		reloadTimer.start(2)
	else: 
		text = "You won!"
		showButtons.emit(true)


func _on_lock_in_player_2_win():
	Global.p1Lives -= 1
	if Global.p1Lives != 0:
		text = "Round lost.\n Get ready..."
		reloadTimer.start(2)
	else: 
		text = "You lost :("
		showButtons.emit(true)

func _on_lock_in_game_draw():
	text = "Draw!\nGet ready..."
	reloadTimer.start(2)


func _on_reload_timer_timeout():
	get_tree().reload_current_scene()
