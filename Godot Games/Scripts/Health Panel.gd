extends Panel


@export var health: Array[Node]

func _ready():
	health = get_children()

func _process(delta):
	updateHealth(round(Global.PLAYER_HEALTH))

func updateHealth(amm):
	for i in health:
		i.hide()
	
	for i in amm / 2:
		if(i < len(health)):
			health[i].show()
