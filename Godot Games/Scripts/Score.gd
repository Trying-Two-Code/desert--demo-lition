extends RichTextLabel

var oldText = 0
var modifier = 1
func _process(delta):
	Global.SCORE += roundi(delta + 2)
	if(oldText != Global.SCORE):
		oldText = Global.SCORE
		scale.x = 1.2
		scale.y = 1.2
		text = str(Global.SCORE)
		await get_tree().create_timer(.1).timeout
		scale.x = 1
		scale.y = 1
		
