extends CharacterBody2D

@onready var detection_box = $DetectionBox

var speed = 200.0
var attack_range = 50
var attack_damage = 10
var attack_cooldown = 1.0

var target = null
var can_attack = true

func _ready():
	pass
	
func _physics_process(delta):
	pass
	

func _on_detection_box_body_entered(body):
	if body.is_in_group("player"):
		target = body
		print("Target detected")
