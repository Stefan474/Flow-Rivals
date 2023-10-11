extends Node2D


func _on_button_pressed():
	Global.character = "Samurai"
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_button_2_pressed():
	Global.character = "Default"
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://Tutorial.tscn")
