extends CharacterBody2D

const Speed = 14 + 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += 100 * Speed * delta

func _ready():
	randomize()
	position.y -= 1500

