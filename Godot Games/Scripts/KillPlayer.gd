extends StaticBody2D



func _on_area_2d_body_entered(body):
	checkForPlayer(body)


func checkForPlayer(body):
	if body.name == "Player" or body.is_in_group("enemy"):
		body.queue_free()
		if body.name == "Player":
			get_tree().reload_current_scene()
		if body.is_in_group("enemy"):
			Global.SCORE += 5
		#reload sceene


func _on_area_2d_body_exited(body):
	checkForPlayer(body)
