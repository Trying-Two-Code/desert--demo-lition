extends CharacterBody2D

const SPEED = 1000.0

@export var hurtEnemy: bool = false

func _physics_process(delta):
	position.y += -SPEED * delta

func _on_area_2d_body_entered(body):
	print("hit something: ", body)
	if body.is_in_group("enemy") and hurtEnemy:
		body.queue_free()
		queue_free()
		Global.SCORE += 500
		self.queue_free()
	elif !hurtEnemy and body.is_in_group("Player"):
		body.Hurt()
		self.queue_free()
