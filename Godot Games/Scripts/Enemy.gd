extends CharacterBody2D



const DRAG = 0.005
const DRAGMAX = 100.0
const SPEED = 500.0
const SIDEWAYSSPEED = 200.0
const ACCEL = 4.9

@onready var player = get_tree().get_first_node_in_group("Player")
@export_enum("Attack", "Chase", "Run") var action
@export_enum("Gunner", "Bomber") var Type

var change = 0
var changeDelta = 0.5
@export var targetY = -600

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	changeDelta = rng.randf_range(1, 5)
	


func move(delta, direction = [0, 0]):
	velocity.y = lerp(velocity.y, direction[1] * SPEED, delta * ACCEL)
	velocity.x = lerp(velocity.x, direction[0] * SIDEWAYSSPEED * abs(-direction[1] + 1), delta * ACCEL)
	
	#print(direction[1] * SPEED)

func goto(delta, goToPosition = [0, 0]):
	if goToPosition[1] < position.y:
		move(delta, [0, -1])
	elif goToPosition[1] > position.y and position.y < 350:
		move(delta, [0, 1])
	if goToPosition[0] < position.x:
		move(delta, [-1, 0])
		$AnimationPlayer.play("left")
	elif goToPosition[0] > position.x:
		move(delta, [1, 0])
		$AnimationPlayer.play("right")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		if(action == 1):   # chase
			goto(delta, player.position - Vector2(0, targetY))
			checkAnim()
		elif(action == 0): # attack
			if(Type == 0): # 0 is gunner
				gun(delta)
			if(Type == 1): # 1 is bomber
				bomb(delta)
		elif(action == 2): # run
			goto(delta, Vector2(position.x, position.y / 2) - Vector2(-player.position.x, 0))
			
	
	change += delta / changeDelta
	action = round(change)
	if(change > 2):
		change = 0
		
	
	move_and_slide()
	
func bomb(delta):
	goto(delta, player.position - Vector2(0, 400))
	checkAnim(false)

func gun(delta):
	goto(delta, player.position - Vector2(0, -400))
	checkAnim(false)

func checkAnim(normal = true):
	if(normal):
		if(player.position.x > position.x + 100):
			$AnimationPlayer.play("right")
		elif(player.position.x < position.x - 100):
			$AnimationPlayer.play("left")
		else:
			$AnimationPlayer.play("RESET")
	else:
		$AnimationPlayer.play("RESET")
