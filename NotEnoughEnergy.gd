extends Control

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.not_enough_energy = false
	global_position.x = -300
	global_position.y = -300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameController.not_enough_energy == true:
		global_position.x = 0
		global_position.y = 0
		GameController.not_enough_energy = false
		timer.start()


func _on_timer_timeout():
	global_position.x = -300
	global_position.y = -300
