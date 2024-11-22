extends Control

@onready var day_night_label = $Label
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameController.time == "day":
		day_night_label.text = "Day " + str(GameController.day_count)
	elif GameController.time == "night":
		day_night_label.text = "Night " + str(GameController.day_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
