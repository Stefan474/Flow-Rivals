extends Sprite2D

var texture0 = preload("res://Assets/Cards/Default/PlaceholderCard.png")
var texture1 = preload("res://Assets/Cards/Default/charge.png")
var texture2 = preload("res://Assets/Cards/Default/shield.png")
var texture3 = preload("res://Assets/Cards/Default/Attack.png")
var texture4 = preload("res://Assets/Cards/Default/ultimate.png")

func _ready():
	if Global.character == "Samurai":
		texture0 = preload("res://Assets/Cards/Default/PlaceholderCard.png")
		texture1 = preload("res://Assets/Cards/SamuraiGirl/charge.png")
		texture2 = preload("res://Assets/Cards/SamuraiGirl/shield.png")
		texture3 = preload("res://Assets/Cards/SamuraiGirl/attack.png")
		texture4 = preload("res://Assets/Cards/SamuraiGirl/ultimate.png")

func _on_lock_in_change_display_card(val, shiny = false):
	match(val):
		0: texture = texture0
		1: texture = texture1
		2: texture = texture2
		3: texture = texture3 
		4: texture = texture4
		
	if shiny == true:
		modulate = Color("yellow")
	else: 
		modulate = Color("white")

func _on_enemy_card_restart_picked_card():
	texture = texture0
