extends CanvasGroup


@onready var health1 = $EHealth
@onready var health2 = $EHealth2
@onready var health3 = $EHealth3
@onready var flashTimer = $shader_hurt_timer

var health = 3




func resetFlashShader():
	health2.material.set_shader_parameter("active", false)
	health1.material.set_shader_parameter("active", false)
	health1.material.set_shader_parameter("active", false)	

func _on_enemy_manager_change_enemy_hp(hp):
	health2.material.set_shader_parameter("active", true)
	health1.material.set_shader_parameter("active", true)
	health1.material.set_shader_parameter("active", true)	
	flashTimer.start(0.1)
	health = hp
	
func _ready():
	health1.visible = true
	health2.visible = true
	health3.visible = true		
	resetFlashShader()

func _on_shader_hurt_timer_timeout():
	resetFlashShader()
	match health:
		3:
			health1.visible = true
			health2.visible = true
			health3.visible = true	
		2: 
			health3.visible = false
			health2.visible = true
			health1.visible = true
		1: 
			health3.visible = false
			health2.visible = false
			health1.visible = true
		0: 
			health1.visible = false
			health2.visible = false
			health3.visible = false	
