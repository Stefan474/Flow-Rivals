extends Sprite2D

var texture0 = preload("res://Assets/Cards/Default/ultimate_enemy0.png")
var texture1 = preload("res://Assets/Cards/Default/ultimate_enemy.png")

func _on_lock_in_enemy_ult_available():
	texture = texture1


func _on_lock_in_p_2_ult_take():
	texture = texture0
