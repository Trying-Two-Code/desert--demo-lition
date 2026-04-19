extends Node2D


var enemyList = []

@onready var spawnpoint = get_tree().get_nodes_in_group("Spawn Points")

@onready var enemy = preload("res://Scenes/enemy.tscn")
@onready var bomber = preload("res://Scenes/enemy - bomber.tscn")

const SPAWN_RATE = 5.1
var lastSpawned = 0
var bomberSpawnPercentage = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	SpawnEnemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(lastSpawned <= 0):
		lastSpawned = SPAWN_RATE
		randomize()
		SpawnEnemy()
	else:
		lastSpawned -= delta
	
func SpawnEnemy():
	var en = randi_range(0, 100)
	var newEnemy = null
	if en <= bomberSpawnPercentage:
		newEnemy = bomber.instantiate()
	else:
		newEnemy = enemy.instantiate()
	add_child(newEnemy)
	newEnemy.position = spawnpoint[randi_range(0, 3)].position
	enemyList.append(newEnemy)
