extends Area2D

@onready var moving: bool = true
@onready var animated_sprite = $AnimatedSprite2D
signal npc_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving == true:
		position.x += 1

func _on_area_entered(area):
	if area.is_in_group("marks"):
		moving = false
		animated_sprite.play("talking")
		npc_ready.emit()
