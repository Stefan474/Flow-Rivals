extends AudioStreamPlayer2D

var one
var two 
var three

func _on_match_countdown_start_ost():
	one = preload("res://Assets/Sounds/75bpmsong2.mp3")
	two = preload("res://Assets/Sounds/90bpm_test_2.mp3")
	three = preload ("res://Assets/Sounds/120bpmsong.mp3")
	
	if Global.p1Lives == 1 || Global.p2Lives == 1:
		stream = three
	elif Global.p1Lives == 2 || Global.p2Lives == 2:
		stream = two
	else:
		stream = one
	
	if stream == two:
		play(21.40)
	else:
		play()


func _on_match_countdown_get_speed():
	
	pass
