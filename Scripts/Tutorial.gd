extends Sprite2D


@onready var two = preload ("res://Assets/Menu/Tutorial/Rules 2.png") 
@onready var three = preload ("res://Assets/Menu/Tutorial/Rules 3.png") 
@onready var four = preload ("res://Assets/Menu/Tutorial/Rules 4.png") 
@onready var five = preload ("res://Assets/Menu/Tutorial/Rules 5.png") 

var scene = 1 

func _unhandled_key_input(event):
	if event.is_pressed():
		if scene == 1:
			texture = two
			scene +=1
		elif scene == 2: 
			texture = three
			scene += 1
		elif scene == 3: 
			texture = four
			scene += 1
		elif scene == 4:
			texture = five
			scene += 1
		else:
			get_tree().change_scene_to_file("res://menu.tscn")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if scene == 1:
			texture = two
			scene +=1
		elif scene == 2: 
			texture = three
			scene += 1
		elif scene == 3: 
			texture = four
			scene += 1
		elif scene == 4:
			texture = five
			scene += 1
		else:
			get_tree().change_scene_to_file("res://menu.tscn")
