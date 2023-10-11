extends Sprite2D

var samuraiTexture = preload("res://Assets/Cards/SamuraiGirl/charge.png")
var defaultTexture = preload("res://Assets/Cards/Default/charge.png")

@onready var inputTimer = $inputTimer
@export var hold_time = 0.2

signal add_ammo()

func _ready():
	if Global.character == "Samurai":
		texture = samuraiTexture
	elif Global.character == "Default":
		texture = defaultTexture

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("You clicked on charge Sprite!")
			add_ammo.emit()
	elif Input.is_action_just_pressed("Spell1"):
		add_ammo.emit()
		inputTimer.start(hold_time)
	if Input.is_action_just_released("Spell1"):
		if inputTimer.is_stopped() == true:
			add_ammo.emit(true)
