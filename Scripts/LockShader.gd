extends Sprite2D




func _on_sound_controller_beat_visualizer_pace(speed):
	if speed == 0.8:
		material.set_shader_parameter("speed", 3.8)
		print("Does this run?")
	elif speed == 0.666:
		material.set_shader_parameter("speed", 4.7)
	elif speed == 0.5:
		material.set_shader_parameter("speed", 5.8)
	else:
		material.set_shader_parameter("speed", 0.1)
		print ("unexpected passed speed value in the beatGlow shader")
