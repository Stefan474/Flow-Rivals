extends Camera2D


#variables

@onready var shake_timer = $shake_timer
@onready var shake_intensity = 0
var default_offset = offset

@export var shake_strength = 1 #walk_shake_intensity


func _ready():
	Global.screen_shake.connect(screen_shake)
	set_process(false)
	rotation = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var shake_vector = Vector2(randf_range(-1,1) * shake_intensity, randf_range(-1,1) * shake_intensity)
	var tween = create_tween()
	tween.tween_property(self, "offset", shake_vector, 0.1)

func _on_sound_controller_screen_shake():
	screen_shake(shake_strength)

func screen_shake(_intensity):
	set_process(true)
	shake_intensity = shake_strength
	shake_timer.start(0.1)

func _on_shake_timer_timeout():
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self, "offset", default_offset, 0.1)
