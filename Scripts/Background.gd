extends Sprite2D

var samuraiTexture = preload("res://Assets/Cards/SamuraiGirl/bg1.png")
var defaultTexture = preload("res://Assets/Cards/Default/bg_1.png")

func _ready():
	if Global.character == "Samurai":
		texture = samuraiTexture
	elif Global.character == "Default":
		texture = defaultTexture
