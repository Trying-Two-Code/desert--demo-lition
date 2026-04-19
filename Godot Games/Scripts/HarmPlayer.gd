extends Area2D

var hurting = []
@export var enemyParticles: PackedScene

var scoreMult = 1.1

func _ready():
	scoreMult = 1.1

func _process(delta):
	if(len(hurting) > 0):
		HurtBody(hurting)

func _on_body_entered(body):
	
	if body.is_in_group("Player"):
		body.Hurt(2)
	
	if(body.name == "Player" or body.is_in_group("enemy")):
		if body.is_in_group("enemy"):
			Global.SCORE += round(50 * scoreMult)
			scoreMult += 1
		
		hurting.append(body)
		if(body.name != "Player"):
			var en = enemyParticles.instantiate()
			get_tree().current_scene.add_child(en)
			en.position = global_position
	
	
			

func HurtBody(bodies):
	for body in bodies:
		if(body != null):
			body.position.y += 50


func _on_body_exited(body):
	if(body.name == "Player"):
		hurting.erase(body)


func _on_body_entered_red_truck(body):
	if body.is_in_group("Player"):
		body.Hurt(3)
	
	if(body.name == "Player" or body.is_in_group("enemy")):
		hurting.append(body)
		if(body.name != "Player"):
			var en = enemyParticles.instantiate()
			get_tree().current_scene.add_child(en)
			en.position = global_position
	


func _on_body_exited_red_truck(body):
	if(body.name == "Player"):
		hurting.erase(body)
	
