extends Node2D

@export var In: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	In -= delta
	if In <= 0:
		get_parent().queue_free()
