extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = -3
	global_position.x = 120
	global_position.y = 144


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += 5.04 * delta

func _on_timer_timeout():
	queue_free()
