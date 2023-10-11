extends AnimationPlayer



func _on_lock_in_change_display_card(_card, ex = false):
	if ex == false:
		play("cardSlam")
	elif ex == false:
		play("make_gold")
