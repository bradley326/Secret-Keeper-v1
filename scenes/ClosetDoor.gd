extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameController.time == "day":
		modulate.a = 0.75
	if GameController.time == "night":
		modulate.a = 0.25


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
