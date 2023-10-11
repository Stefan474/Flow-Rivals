extends Sprite2D

signal ammo_fill() #p1 ammo fill
signal ammo_take()
signal lock_move() #send ammo status to CPU for decisionmaking
signal p2ammo_fill() 
signal p2ammo_take()
signal p2ult_take() #take 5 ammo
signal ammoNotif() #notification when pressing attack without ammo
signal changeDisplayCard() #Changes sprite for card pick
signal stopCardChangeTimer()
signal changeAttackTexture()
signal ultimateCounter()
signal enemyUltAvailable()
signal resetCombo() #resets combo after successful EX

#signals checking beat timing
signal checkTimingKick()
signal checktimingClap()

signal player1Win()
signal player2Win()
signal gameDraw()
signal showEndScreen()
signal stop_music()

signal sendState()
signal hurtp1() #hurt player 1 and 2
signal hurtp2()
signal sendHealth()

signal p1ammoPass() #ammo info for labels
signal p2ammoPass()

signal exProperty(character, spell)

@onready var inputTimer = $input_timer

var state = 0 # 1 = ammo, 2 = defense, 3 = attack
var playerAmmo = 0 
var p2ammo = 0

var p1hp = 3
var p2hp = 3

var speed = 0.8

var actionLockout = 0 #lets you play 1 card per cycle
var lockoutCounter = 0 #resets every 2 beats (1kick 1 clap) to delete lockout

var combo = 0 

# CHANGE THIS SO THAT IT ALSO TELLS IT"S TOO LATE RELEASE IF STATE IS 0
func checkComboEX(special): #checks whether a certain character has special combo req
	if state != 0:		
		match special:
			1: 
				if combo >= 15:
					return true
			2:
				if combo >= 20:
					return true
			3:
				if combo >= 25:
					return true
	else: 
		return false
	

func _on_charge_sprite_add_ammo(ex = false): #charge
	if actionLockout == 1 && ex == false:
		return
	if ex == false:
		state = 1
		changeDisplayCard.emit(1)
		stopCardChangeTimer.emit()
		checkTimingKick.emit("kick")
		actionLockout = 1
	elif Global.character == "Default":
		if ex == true && checkComboEX(2):
			state = 11
			changeDisplayCard.emit(1, true)
	elif ex == true && checkComboEX(1):
		state = 11
		changeDisplayCard.emit(1, true)
	
func _on_shield_sprite_add_defense(ex = false): #defense
	if actionLockout == 1 && ex == false:
		return
	if ex == false:
		state = 2 
		changeDisplayCard.emit(2)
		stopCardChangeTimer.emit()
		checkTimingKick.emit("kick")
		actionLockout = 1
	elif ex == true && checkComboEX(1):
		state = 12
		changeDisplayCard.emit(2, true)

func _on_ultimate_player_1_win(ex = false): #ulti
	if actionLockout == 1 && ex == false:
		return
	if ex == false:
		state = 4
		changeDisplayCard.emit(4)
		stopCardChangeTimer.emit()
		checkTimingKick.emit("kick")
		actionLockout = 1

func _on_attack_sprite_add_attack(ex = false): #attack
	if playerAmmo > 0:
		if actionLockout == 1 && ex == false:
			return
		if ex == false:
			state = 3
			changeDisplayCard.emit(3)
			stopCardChangeTimer.emit()
			checkTimingKick.emit("kick")
			actionLockout = 1
		elif Global.character == "Samurai":
			if ex == true && checkComboEX(2):
				state = 13
				changeDisplayCard.emit(3, true)
		
		elif ex == true && checkComboEX(1) && Global.character != "Samurai":
			state = 13
			changeDisplayCard.emit(3, true)
	else:
		ammoNotif.emit()
		changeDisplayCard.emit(0)
		stopCardChangeTimer.emit()
		
func _on_clap_sound_auto_lock():
	if state == 0:
		lock_move.emit(5, playerAmmo)
	else:
		lock_move.emit(state, playerAmmo)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			#lock_move.emit(state, playerAmmo)
			checkTimingKick.emit("clap")
			
	elif Input.is_action_just_pressed("Lockin"):
		#lock_move.emit(state, playerAmmo)
		checkTimingKick.emit("clap")

func ammoAdd(val, target, ult = false):
	
	if val > 0:
		if target == "player":
			for i in val:
				ammo_fill.emit()
			playerAmmo += val
		elif target == "enemy":
			for i in (val):
				p2ammo_fill.emit()
			p2ammo += val
	elif val < 0:
		if target == "player":
			for i in val:
				ammo_take.emit()
			playerAmmo += val
		elif target == "enemy":
			for i in -val:
				p2ammo_take.emit()
			p2ammo += val
			print ("haha added negative ammo, it is now = " + str(p2ammo))
	p1ammoPass.emit(playerAmmo)
	p2ammoPass.emit(p2ammo)
	
	if ult == true && target == "enemy":
		p2ult_take.emit()

func checkWinner(): #checks to see if anyone hit 0 hp
	if p1hp == 0 && p2hp == 0:
		gameDraw.emit()
		showEndScreen.emit()
		stop_music.emit()
	if p1hp <= 0:
		print("ez win p2")
		player2Win.emit()
		showEndScreen.emit()
		stop_music.emit()
	elif p2hp <= 0:
		print("ez win p1")
		player1Win.emit()
		showEndScreen.emit()
		stop_music.emit()

func hurt(val, target, skip = false):
	if target == "player":
		for i in val:
			hurtp1.emit()
		p1hp -= val
		sendHealth.emit(p1hp)
	elif target == "enemy":
		for i in val:
			hurtp2.emit()
		p2hp -= val
	if skip == true:
		return
	checkWinner()

func _on_enemy_manager_p_2_state(p2state):
	if state > 10: 
		exLogic(state, p2state)
	elif state == 1 && p2state == 1:
		ammoAdd(1, "player")
		ammoAdd(1, "enemy")
	elif state == 1 && p2state == 2:
		ammoAdd(1, "player")
	elif state == 1 && p2state == 3:
		ammoAdd(1, "player")
		ammoAdd(-1, "enemy")
		hurt(1, "player")
	elif state == 1 && p2state == 4: 
		hurt(1, "player")
		ammoAdd(-5, "enemy", true)
	elif state == 2 && p2state == 1:
		ammoAdd(1, "enemy")
	elif state == 2 && p2state == 2:
		pass
	elif state == 2 && p2state == 3:
		ammoAdd(-1, "enemy")
	elif state == 2 && p2state == 4: #abstract this to just ult function and 
		hurt(1, "player")            #check enemy modifiers in the function itself?
		ammoAdd(-5, "enemy", true)
	elif state == 3 && p2state == 1:
		ammoAdd(1, "enemy")
		ammoAdd(-1, "player")
		hurt(1, "enemy")
	elif state == 3 && p2state == 2:
		ammoAdd(-1, "player")
	elif state == 3 && p2state == 3:
		ammoAdd(-1, "player")
		ammoAdd(-1, "enemy")
	elif state == 4 && p2state != 4: #ult fallback
		ammoAdd(-5, "player")
		hurt(1, "enemy")
	elif state != 4 && p2state == 4: #ult fallback
		hurt(1, "player")            
		ammoAdd(-5, "enemy", true)
	elif state == 4 && p2state == 4:
		hurt(1, "player", true)
		hurt(1, "enemy")
		ammoAdd(-5, "player")
		ammoAdd(-5, "enemy", true)
	elif state == 5 || state == 0 && p2state == 1:
		ammoAdd(1, "enemy")
	elif state == 5 || state == 0 && p2state == 2:
		pass
	elif state == 5 || state == 0 && p2state == 3:
		ammoAdd(-1, "enemy")
		hurt(1, "player")
	else:
		print("something is very wrong with your logic :) check line 91 in lockedin.gd")
	
	
	afterCalcReset()
	


func _on_sound_controller_timeout(): #unlocks player action every 2 beats (on clap)
	
	if lockoutCounter == 0:
		lockoutCounter+=1
	else:
		lockoutCounter = 0
		actionLockout = 0

#all logic for EX spells Q_Q this will have 3000 lines by the end
func exLogic(p1, p2):
	sendState.emit(p1)
	if Global.character == "Samurai": #samurai logic
		if p1 == 13:
			if p2 == 1:
				hurt(1, "enemy")
				ammoAdd(1, "enemy")
			elif p2 == 11:
				hurt(1, "enemy")
				ammoAdd(2, "enemy")
			elif p2 == 2 || p2 == 12:
				pass
			elif p2 == 3 || p2 == 13:
				hurt(2, "enemy")
				ammoAdd(-1, "enemy")
				ammoAdd(-1, "player")
			elif p2 == 4:
				hurt(1, "player")
				ammoAdd(-5, "enemy", true)
				ammoAdd(-1, "player")
		elif p1 == 12:
			if p2 == 1:
				ammoAdd(1, "enemy")
			elif p2 == 11:
				ammoAdd(2, "enemy")
			elif p2 == 2 || p2 == 12:
				pass
			elif p2 == 3 || p2 == 13:
				ammoAdd(-1, "enemy")
			elif p2 == 4:
				ammoAdd(-5, "enemy", true)
				print ("does this even run???")
		elif p1 == 11:
			if p2 == 1:
				ammoAdd(2, "player")
				ammoAdd(1, "enemy")
			elif p2 == 11:
				ammoAdd(2, "player")
				ammoAdd(2, "enemy")
			elif p2 == 2 || p2 == 12:
				ammoAdd(2, "player")
			elif p2 == 3:
				ammoAdd(2, "player")
				hurt(1, "player")
			elif p2 == 13:
				ammoAdd(2, "player")
				hurt(2, "player")
			elif p2 == 4:
				ammoAdd(2, "player")
				hurt(1, "player")
				ammoAdd(-5, "enemy", true)
		
	elif Global.character == "Default": #Galaxy guy logic
		if p1 == 13:
			if p2 == 1:
				hurt(2, "enemy")
				ammoAdd(1, "enemy")
			elif p2 == 11:
				hurt(2, "enemy")
				ammoAdd(2, "enemy")
			elif p2 == 2 || p2 == 12:
				pass
			elif p2 == 3 || p2 == 13:
				pass
			elif p2 == 4:
				hurt(1, "player")
				ammoAdd(-5, "enemy", true)
				ammoAdd(-1, "player")
		elif p1 == 12:
			if p2 == 1:
				ammoAdd(1, "enemy")
			elif p2 == 11:
				ammoAdd(2, "enemy")
			elif p2 == 2 || p2 == 12:
				pass
			elif p2 == 3 || p2 == 13:
				ammoAdd(-1, "enemy")
			elif p2 == 4:
				ammoAdd(-5, "enemy", true)
				print ("does this even run???")
		elif p1 == 11:
			if p2 == 1:
				ammoAdd(7, "player")
			elif p2 == 11:
				ammoAdd(7, "player")
				ammoAdd(1, "enemy")
			elif p2 == 2 || p2 == 12:
				ammoAdd(5, "player")
			elif p2 == 3:
				ammoAdd(5, "player")
				hurt(1, "player")
			elif p2 == 13:
				ammoAdd(5, "player")
				hurt(2, "player")
			elif p2 == 4:
				ammoAdd(5, "player")
				hurt(1, "player")
				ammoAdd(-5, "enemy", true)
	#after every calc stuff, leave as is	
	afterCalcReset()
	resetCombo.emit()


#resets state and updates textures based on ammo
func afterCalcReset(): 
	state = 0
	if playerAmmo > 0:
		changeAttackTexture.emit(1)
	else:
		changeAttackTexture.emit(0)
	ultimateCounter.emit(playerAmmo)
	if p2ammo >= 5:
		enemyUltAvailable.emit()

func _on_node_2d_send_combo_counter(comboCounter):
	combo = comboCounter


func _on_sound_controller_send_speed(val):
	speed = val
