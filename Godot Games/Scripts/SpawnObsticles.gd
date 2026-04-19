extends Node2D

@export var obsticles: Array[PackedScene]

const TIMETOSPAWN = 5

func _ready():
	randomize()

func SpawnObsticle(objList=[], xRange=[-300, 300], y=-1080):
	if objList.size() == 0:
		return false
	var random_index = randi() % objList.size()
	var objChoice = objList[random_index]
	var newObsticle = objChoice.instantiate()
	add_child(newObsticle)
	newObsticle.position.y = y
	var random_integer = randi() % (xRange[1] - xRange[0] + 1) + xRange[0]
	newObsticle.position.x = random_integer
	print(newObsticle)

var t = 5
func _process(delta):
	t -= delta
	if(t <= 0):
		print("Spawn")
		t = TIMETOSPAWN
		SpawnObsticle(obsticles)
