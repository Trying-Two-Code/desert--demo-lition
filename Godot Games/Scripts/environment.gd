extends Node2D

@export var tileScene: PackedScene
var tiles = []
var canSpawn = true
var speed = 1.5

func _ready():
	spawnTile(0)

func _process(delta):
	for ti in tiles:
		ti.position.y += delta * 100 * speed
		if(ti.position.y >= 0 and canSpawn):
			spawnTile()
			canSpawn = false
		if(ti.position.y >= 100):
			tiles.erase(ti)
			ti.queue_free()
			canSpawn = true

func spawnTile(ypos = -100):
	var new_tile = tileScene.instantiate()
	add_child(new_tile)
	new_tile.position.y = ypos
	tiles.append(new_tile)
