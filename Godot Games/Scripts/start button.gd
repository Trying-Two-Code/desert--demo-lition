extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = .5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button_pressed:
		$"..".hide()
		Global.PLAYER_HEALTH = 6
		$"../../Environment & Player/Player".position = Vector2(0, -100)
		Global.SCORE = 0
		$"../../UI canvas".show()
		Engine.time_scale = 1
