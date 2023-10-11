extends HFlowContainer

@onready var ammoText = $ammo_text
@onready var icon1 = $ammo_icon
@onready var icon2 = $ammo_icon2
@onready var icon3 = $ammo_icon3
@onready var icon4 = $ammo_icon4
@onready var icon5 = $ammo_icon5
@onready var icon6 = $ammo_icon6
@onready var icon7 = $ammo_icon7
@onready var icon8 = $ammo_icon8


var ammo = 0


func _on_lock_in_p_1_ammo_pass(val):
	
	hideAll()
	ammoText.text = str(val)
	
	match val:
		1:
			icon1.visible = true
		2:
			icon1.visible = true
			icon2.visible = true
		3:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
		4:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
			icon4.visible = true
		5:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
			icon4.visible = true
			icon5.visible = true
		6:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
			icon4.visible = true
			icon5.visible = true
			icon6.visible = true
			
		7:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
			icon4.visible = true
			icon5.visible = true
			icon6.visible = true
			icon7.visible = true
		8:
			icon1.visible = true
			icon2.visible = true
			icon3.visible = true
			icon4.visible = true
			icon5.visible = true
			icon6.visible = true
			icon7.visible = true
			icon8.visible = true
			
	if val > 8:
		icon1.visible = true
		ammoText.visible = true


func hideAll():
	icon1.visible = false
	icon2.visible = false
	icon3.visible = false
	icon4.visible = false
	icon5.visible = false
	icon6.visible = false
	icon7.visible = false
	icon8.visible = false
	ammoText.visible = false
