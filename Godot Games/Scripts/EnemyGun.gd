extends Node2D

@export var bullet: PackedScene
@export var shootRate = 2

var lastShot = 0

func _process(delta):
	if(lastShot > 0):
		lastShot -= delta



func shoot():
	var newBullet = bullet.instantiate()
	get_tree().current_scene.add_child(newBullet)
	newBullet.position = global_position


func _on_area_2d_body_entered(body):
	if(lastShot <= 0 and body.name == "Player"):
		lastShot = shootRate
		shoot()
