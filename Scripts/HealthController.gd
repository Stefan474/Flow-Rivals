extends CanvasGroup


@onready var health1 = $Health
@onready var health2 = $Health2
@onready var health3 = $Health3
@onready var flashTimer = $shader_hurt_timer

var health = 3


func _on_player_manager_change_hp_ui(hp):
	health2.material.set_shader_parameter("active", true)
	health1.material.set_shader_parameter("active", true)
	health1.material.set_shader_parameter("active", true)	
	flashTimer.start(0.1)
	health = hp
	
func _process(_delta):
	if health == 2:
		var i = 0.0
		while i < 1:
			health3.material.set_shader_parameter("progress", i)
			i+=0.001
	elif health == 1:
		var i = 0.0
		while i < 1:
			health2.material.set_shader_parameter("progress", i)
			i+=0.001
	elif health == 0:
		var i = 0.0
		while i < 1:
			health1.material.set_shader_parameter("progress", i)
			i+=0.001
	
	set_process(false)
	
func _ready():
	health1.visible = true
	health2.visible = true
	health3.visible = true
	match Global.character: #set heart colors
		"Samurai": self.modulate = Color("#00b04c")
		"Default": self.modulate = Color("9a1993")
		
	resetFlashShader()


func _on_shader_hurt_timer_timeout():
	resetFlashShader()
	match health:
		2: health3.visible = false
		1: health2.visible = false
		0: health1.visible = false

func resetFlashShader():
	health2.material.set_shader_parameter("active", false)
	health1.material.set_shader_parameter("active", false)
	health1.material.set_shader_parameter("active", false)	
