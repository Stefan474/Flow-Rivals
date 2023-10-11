extends Sprite2D

signal player1Win()
signal ammoTooltip()

var ammo = 0

var defaultTexture0 = preload("res://Assets/Cards/Default/ultimate_0.png")
var defaultTexture1 = preload("res://Assets/Cards/Default/ultimate_01.png")
var defaultTexture2 = preload("res://Assets/Cards/Default/ultimate_02.png")
var defaultTexture3 = preload("res://Assets/Cards/Default/ultimate_03.png")
var defaultTexture4 = preload("res://Assets/Cards/Default/ultimate_04.png")
var defaultTexture5 = preload("res://Assets/Cards/Default/ultimate.png")

func _ready():
	if Global.character == "Samurai":
		defaultTexture0 = preload("res://Assets/Cards/SamuraiGirl/ultimate_0.png")
		defaultTexture1 = preload("res://Assets/Cards/SamuraiGirl/ultimate_01.png")
		defaultTexture2 = preload("res://Assets/Cards/SamuraiGirl/ultimate_02.png")
		defaultTexture3 = preload("res://Assets/Cards/SamuraiGirl/ultimate_03.png")
		defaultTexture4 = preload("res://Assets/Cards/SamuraiGirl/ultimate_04.png")
		defaultTexture5 = preload("res://Assets/Cards/SamuraiGirl/ultimate.png")
	texture = defaultTexture0

func _on_lock_in_ultimate_counter(val):
	ammo = val
	match val:
		0: texture = defaultTexture0
		1: texture = defaultTexture1
		2: texture = defaultTexture2
		3: texture = defaultTexture3
		4: texture = defaultTexture4
		5: texture = defaultTexture5
		
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				if ammo >= 5:
					player1Win.emit()
				else: ammoTooltip.emit()
	elif Input.is_action_just_pressed("Ult"):
		if ammo >= 5:
			player1Win.emit()
		else: ammoTooltip.emit()
	elif Input.is_action_just_pressed("EXUlt"):
		if ammo >= 5:
			player1Win.emit(true)
		else: ammoTooltip.emit()
