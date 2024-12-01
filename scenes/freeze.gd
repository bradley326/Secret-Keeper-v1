extends Area2D

@onready var size = $CollisionShape2D
@onready var sprite = $AnimatedSprite2D
@onready var sound_effect = $SoundEffect

# Called when the node enters the scene tree for the first time.
func _ready():
	sound_effect.play()
	size.scale.x = GameController.freeze_tool_size_scale
	size.scale.y = GameController.freeze_tool_size_scale
	sprite.scale.x = GameController.freeze_tool_size_scale
	sprite.scale.y = GameController.freeze_tool_size_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
