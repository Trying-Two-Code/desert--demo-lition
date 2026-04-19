extends Node2D

@export var bullet: PackedScene
@export var shootRate = .5

var lastShot = 0

func _process(delta):
	if(Input.get_action_strength("space") && lastShot <= 0):
		shoot()
		lastShot = shootRate
	if(lastShot > 0):
		lastShot -= delta


func shoot():
	var newBullet = bullet.instantiate()
	get_tree().current_scene.add_child(newBullet)
	newBullet.position = global_position
