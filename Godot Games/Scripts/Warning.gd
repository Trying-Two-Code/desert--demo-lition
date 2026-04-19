extends Node2D

@onready var rb = $"../RigidBody2D"

@export var yOffset: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	position.y = 700 + yOffset
	position.x = 0
