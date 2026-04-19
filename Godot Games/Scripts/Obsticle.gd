extends CharacterBody2D

const Speed = 14

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += 100 * Speed * delta

func _ready():
	randomize()
	rotation = randi_range(1, 360)
	position.y -= 1000

  
