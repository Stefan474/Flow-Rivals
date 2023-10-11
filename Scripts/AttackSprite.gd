extends Sprite2D

var defaultTexture0 = preload("res://Assets/Cards/Default/Attack_0.png")
var defaultTexture = preload("res://Assets/Cards/Default/Attack.png")
var samuraiTexture0 = preload("res://Assets/Cards/SamuraiGirl/attack_0.png")
var samuraiTexture = preload("res://Assets/Cards/SamuraiGirl/attack.png")
@onready var inputTimer = $inputTimer

@export var hold_time = 0.2


func _ready():
	if Global.character == "Default":
		texture = defaultTexture0
	elif Global.character == "Samurai":
		texture = samuraiTexture0


signal add_attack()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				print("You clicked on attack Sprite!")
				add_attack.emit()
	elif Input.is_action_just_pressed("Spell3"):
		add_attack.emit()
		inputTimer.start(hold_time)
	if Input.is_action_just_released("Spell3"):
		if inputTimer.is_stopped() == true:
			add_attack.emit(true)
			
			
		
#	elif Input.is_action_just_pressed("EX3"):
#		add_attack.emit(true)



func _on_lock_in_change_attack_texture(val):
	if Global.character == "Default":
		match val:
			0: texture = defaultTexture0 
			1: texture = defaultTexture
	elif Global.character == "Samurai":
		match val:
			0: texture = samuraiTexture0
			1: texture = samuraiTexture


func _on_player_manager_send_ammo_count(_val):
		pass

