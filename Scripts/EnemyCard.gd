extends Sprite2D

var texture0 = preload("res://Assets/Cards/Default/PlaceholderCard.png")
var texture1 = preload("res://Assets/Cards/Default/charge.png")
var texture2 = preload("res://Assets/Cards/Default/shield.png")
var texture3 = preload("res://Assets/Cards/Default/Attack.png")
var texture4 = preload("res://Assets/Cards/Default/ultimate_enemy.png")

signal startTimer()
signal restartPickedCard()

func _on_enemy_manager_change_enemy_display_card(val):
	match(val):
		0: texture = texture0
		1: texture = texture1
		2: texture = texture2
		3: texture = texture3 
		4: texture = texture4
	startTimer.emit()
	
	


func _on_timer_timeout():
	restartPickedCard.emit()
	texture = texture0


func _on_disappear_timer_restart_texture():
	texture = texture0
