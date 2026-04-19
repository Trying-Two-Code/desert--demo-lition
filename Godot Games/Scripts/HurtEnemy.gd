extends Area2D

var hurting = []
@export var enemyParticles: PackedScene
@onready var player = $".."

func _process(delta):
	if(len(hurting) > 0):
		HurtBody(hurting)

func _on_body_entered(body):
	if(body.is_in_group("enemy")):
		hurting.append(body)
		

func HurtBody(bodies):
	for body in bodies:
		if(returnIsHurt(body, player.velocity.y)):
			if(body != null):
				var en = enemyParticles.instantiate()
				get_tree().current_scene.add_child(en)
				en.position = global_position
				body.queue_free()
				hurting.erase(body)
	print(player.velocity.y)

func returnIsHurt(body, velocity):
	if body == null:
		hurting.erase(body)
		return false
	if(body.position.y > player.position.y and velocity > 100):
		return true
	if(body.position.y < player.position.y and velocity < -100):
		return true
	return false

var mult = 1
func _on_body_exited(body):
	if(body.is_in_group("enemy")):
		hurting.erase(body)
		Global.SCORE += round(50 * mult)
		mult += 5
