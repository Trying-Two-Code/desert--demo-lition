extends CharacterBody2D

const DRAG = 0.005
const DRAGMAX = 100.0
const SPEED = 1000.0
const SIDEWAYSSPEED = 600.0
const ACCEL = 5.0

@onready var camera = $"../../Camera2D"
@onready var hurtEnemy = $HurtEnemy
@onready var border = $"../full border/borderarea" 

var input: Vector2
var activeDrag = 0.005
var stunmult = .2
var speedMultiplier = 1

func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input.normalized()
	

var playerInput
var playerInputShift = 0
var hasBeenHurting = 0

func _process(delta):
	playerInput = get_input()
	
	#(1 + ((self.position.y) / 10000))
	if isPowered:
		$CollisionShape2D.disabled = true
	
	if isHurting:
		#activeDrag = DRAG
		velocity.y += activeDrag * 2
		if activeDrag < DRAGMAX:
			activeDrag = lerp(activeDrag, DRAGMAX, delta/4)
		
		velocity.x = lerp(velocity.x, (playerInput.x + playerInputShift) * (SIDEWAYSSPEED * ((speedMultiplier * 0.1) + (1 * .9))) * abs(-playerInput.y + 1), delta * ACCEL)
		velocity.x /= 1.1
		move_and_slide()
		hasBeenHurting += delta
		if(hasBeenHurting > 2):
			get_tree().reload_current_scene()
		return
	hasBeenHurting = 0
	#if(false):#stunned
	#	playerInput = get_input() * stunmult
	#else:
	velocity.y = lerp(velocity.y, playerInput.y * (SPEED * speedMultiplier), delta * ACCEL)
	velocity.x = lerp(velocity.x, (playerInput.x + playerInputShift) * (SIDEWAYSSPEED * ((speedMultiplier * 0.1) + (1 * .9))) * abs(-playerInput.y + 1), delta * ACCEL)
	
	
	if not Input.is_action_pressed("ui_up"):
		velocity.y += activeDrag
		if activeDrag < DRAGMAX:
			activeDrag = lerp(activeDrag, DRAGMAX, delta/4)
		
	else:
		activeDrag = DRAG
	
	if(Input.is_action_pressed("r")):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("ui_left"):
		$PlayerPlayer.play("Left")
	elif Input.is_action_pressed("ui_right"):
		$PlayerPlayer.play("Right")
	else:
		$PlayerPlayer.play("Forward")
		
		
	
	move_and_slide()


func _on_borderarea_body_entered(body):
	if body == $".":
		shiftXInput(-1.5)
func _on_borderarea_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy"):
		return
	if area.get_parent() == $".":
		shiftXInput(-2)

func shiftXInput(shifted = 0):
	if (self.position.x > 10):
		playerInputShift = shifted 
	else:
		playerInputShift = -shifted
	

func _on_borderarea_body_exited(body):
	if body == $".":
		shiftXInput(0)
func _on_borderarea_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area == null:
		return
	if area.is_in_group("enemy"):
		return
	shiftXInput(0)

func _ready():
	Global.PLAYER_HEALTH = 8
	Global.SCORE = 0
	hurtEnemy.set_process(false)
	$Area2D.monitoring = false
	$CollisionShape2D.disabled = false
	#Super_Powered(1, 10)
	pass

@export var isHurting = false
func Hurt(spins = 1):
	Global.PLAYER_HEALTH -= .2 + (spins / 2)
	if(Global.PLAYER_HEALTH <= 0):
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
	activeDrag = DRAG * 10
	cameraShake(0.5)
	velocity.y /= 1.5
	for i in range(spins):
		$PlayerPlayer.play("Hurt")
		await get_tree().create_timer(0.5).timeout
var isPowered = false

func Stop_Super_Powered(_oldSpeed):
	hurtEnemy.set_process(false)
	speedMultiplier = _oldSpeed
	hurtEnemy.visible = false
	isPowered = false
	$Gun.shootRate *= 3
	$Area2D.monitoring = false
	$CollisionShape2D.disabled = false

func Super_Powered(amm = 1, time = 1):
	isPowered = true
	$Gun.shootRate /= 3
	$Area2D.monitoring = true
	$CollisionShape2D.disabled = true
	hurtEnemy.visible = true
	hurtEnemy.mult = 1
	var _oldSpeed = speedMultiplier
	speedMultiplier = _oldSpeed + amm
	hurtEnemy.set_process(true)
	await get_tree().create_timer(time).timeout
	Stop_Super_Powered(_oldSpeed)
	
func cameraShake(trauma):
	camera.add_trauma(trauma)
