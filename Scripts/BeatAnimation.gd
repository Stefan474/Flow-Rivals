extends Sprite2D


@onready var health3 = preload("res://Assets/Icons/health_3.png")
@onready var health2 = preload("res://Assets/Icons/health_2.png")
@onready var health1 = preload("res://Assets/Icons/health_1.png")


func _ready():
	texture = health3
	modulate = Color("green")
	if Global.character == "Default":
		modulate = Color("purple")


func _on_lock_in_send_health(hp):
	match hp:
		3: texture = health3
		2: texture = health2
		1: texture = health1
