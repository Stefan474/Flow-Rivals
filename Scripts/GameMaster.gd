extends Node2D

var p1ammo
var p1health
var p2ammo
var p2health

var p1Lives = Global.p1Lives
var p2Lives = Global.p1Lives
var gameSpeed = 0.8

var comboCounter = 0

@onready var soundController = $SoundController
@onready var comboText = $ComboCounter



signal generate_move()
signal sendComboCounter()

func _on_lock_in_lock_move(player_state, ammo):
	print('player state received and is ' + str(player_state))
	if player_state == 0:
		return
	generate_move.emit(ammo)

func _on_player_manager_show_ammo(val):
	p1ammo = val
	print(p1ammo + "this is in gamemaster")


func _on_button_pressed():
	Global.p1Lives = 3
	Global.p2Lives = 3
	get_tree().reload_current_scene()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
	Global.p1Lives = 3
	Global.p2Lives = 3

func setSpeed():
	soundController = $SoundController
	soundController.speed = gameSpeed


func _on_sound_controller_combo_reset():
	comboCounter = 0
	comboText.text = str(comboCounter)
	comboText.visible = false
	comboText.modulate = Color("white")

func _on_sound_controller_combo_up():
	comboCounter += 1
	comboText.text = str(comboCounter)
	comboText.visible = true
	if comboCounter >= 15 && comboCounter < 20 :
		comboText.modulate = Color("yellow")
	elif comboCounter >= 20:
		comboText.modulate = Color("red")
	sendComboCounter.emit(comboCounter)

