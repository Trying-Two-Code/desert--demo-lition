extends CharacterBody2D

const Speed = 14

@onready var anim = $AnimationPlayer

func _process(delta):
	position.y += 100 * Speed * delta

func _on_explosion_area_body_entered(body):
	if(body.name == "Player"):
		body.Hurt(1)
		anim.play("break apart")
		anim.play("explode")
	
