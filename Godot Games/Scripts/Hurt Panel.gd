extends Panel

var bl = .5

func _process(delta):
	if(Global.PLAYER_HEALTH <= 2 and bl <= 0):
		_blink()
		bl = .5
	elif(Global.PLAYER_HEALTH <= 2):
		bl -= delta
	else:
		self.hide()

func _blink():
	self.show()
	await get_tree().create_timer(.3).timeout
	self.hide()
	await get_tree().create_timer(.2).timeout
