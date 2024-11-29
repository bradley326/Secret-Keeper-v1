extends Area2D

@onready var size = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	size.scale.x = GameController.freeze_tool_size_scale
	size.scale.y = GameController.freeze_tool_size_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
