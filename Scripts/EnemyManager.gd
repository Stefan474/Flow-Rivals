extends TextEdit


var p2health = 3
var p2ammo = 0
var state = 0

signal p2State()
signal changeEnemyDisplayCard()
signal changeEnemyHp()

func _ready():
	text = "Ammo: " + str(p2ammo)

func _on_node_2d_generate_move(p1ammo):
	if p2ammo == 5:
		p2State.emit(4)
		changeEnemyDisplayCard.emit(4)
		print("ulti momenat")
		return
	if p1ammo == 0 && p2ammo > 0:
		var rng = RandomNumberGenerator.new()
		var player2_choice = rng.randf_range(0.0, 2.0)
		if player2_choice <= 1:
			p2State.emit(1)
			print("Player 2 recharged cause p1 has no ammo")
			changeEnemyDisplayCard.emit(1)
			return
		else:
			p2State.emit(3)
			print("Player 2 attacked cause p1 has no ammo")
			changeEnemyDisplayCard.emit(3)
			return
	elif p1ammo == 0 && p2ammo == 0:
		p2State.emit(1)
		print("Player 2 recharged cause nobody has ammo")
		changeEnemyDisplayCard.emit(1)
		return
	elif p1ammo > 0 && p2ammo == 0:
		var rng = RandomNumberGenerator.new()
		var player2_choice = rng.randf_range(0.0, 2.0)
		if player2_choice <= 1:
			p2State.emit(1)
			changeEnemyDisplayCard.emit(1)
			print("Player 2 recharged cause p1 has no ammo (risky)")
			return
		else:
			p2State.emit(2)
			changeEnemyDisplayCard.emit(2)
			print("Player 2 defended p1 has ammo")
			return
	else:
		var rng = RandomNumberGenerator.new()
		var player2_choice = rng.randf_range(0.0, 3.0)
		if player2_choice > 0 && player2_choice <= 1:
			p2State.emit(1)
			changeEnemyDisplayCard.emit(1)
			print("rps moment charge")
			return
		elif player2_choice > 1 && player2_choice <= 2:
			p2State.emit(2)
			changeEnemyDisplayCard.emit(2)
			print("rps moment def")
			return
		else:
			p2State.emit(3)
			changeEnemyDisplayCard.emit(3)
			print("rps moment att")
			return


func _on_lock_in_p_2_ammo_fill():
	p2ammo+=1
	text = "Ammo: " + str(p2ammo)


func _on_lock_in_p_2_ammo_take():
	p2ammo-=1
	text = "Ammo: " + str(p2ammo)



func _on_lock_in_hurtp_2():
	p2health -= 1
	text = "Ammo: " + str(p2ammo)
	changeEnemyHp.emit(p2health)
