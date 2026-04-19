extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false and $"../Start Game".visible == false:
		self.show()
		get_tree().paused = true
	
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		self.hide()
		get_tree().paused = false


func _on_button_pressed():
	self.hide()
	get_tree().paused = false
