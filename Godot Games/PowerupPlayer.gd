extends Area2D


@export var playerParticles: PackedScene


func _on_body_entered(body):
	if(body.name == "Player"):
		Global.PLAYER_HEALTH += 1
		body.Super_Powered(0.5, 4)
		var en = playerParticles.instantiate()
		get_tree().current_scene.add_child(en)
		en.position = global_position
		get_parent().queue_free()

