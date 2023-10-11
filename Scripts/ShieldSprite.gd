extends Sprite2D

var samuraiTexture = preload("res://Assets/Cards/SamuraiGirl/shield.png")
var defaultTexture = preload("res://Assets/Cards/Default/shield.png")
@onready var inputTimer = $inputTimer

@export var hold_time = 0.2 

func _ready():
	if Global.character == "Samurai":
		texture = samuraiTexture
	elif Global.character == "Default":
		texture = defaultTexture

signal add_defense()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("You clicked on shield Sprite!")
			add_defense.emit()
	elif Input.is_action_just_pressed("Spell2"):
		print("You clicked on shield Sprite!")
		add_defense.emit()
		inputTimer.start(hold_time)
	if Input.is_action_just_released("Spell2"):
		if inputTimer.is_stopped() == true:
			add_defense.emit(true)
