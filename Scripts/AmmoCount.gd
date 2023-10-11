extends TextEdit

signal changeHpUI()
signal sendAmmoCount()

var ammo = 0 : set = add_ammo, get = get_ammo
var health = 3

func _ready():
	text = "Health: " + str(health) + "\nAmmo: " + str(ammo)

func add_ammo(val):
	ammo += val
	text = "Health: " + str(health) + "\nAmmo: " + str(ammo)

func _on_lock_in_ammo_fill():
	add_ammo(1)

func get_ammo():
	return ammo

func _on_lock_in_hurtp_1():
	health -= 1
	text = "Health: " + str(health) + "\nAmmo: " + str(ammo)
	changeHpUI.emit(health)

func _on_lock_in_ammo_take():
	add_ammo(-1)
