extends Node2D

const INTERVAL = 1
var t = 1

@export var bomb: PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(t > 0):
		t -= delta


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		if(t <= 0):
			print("spawn bomb")
			spawn_bomb()

func spawn_bomb():
	if bomb == null:
		print("Error: Bomb scene not assigned!")
		return
	var b = bomb.instantiate()
	get_tree().current_scene.add_child(b)
	t = INTERVAL
	b.position = get_parent().position
	print("Bomb spawned successfully")
