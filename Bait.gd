extends Area2D

@onready var max_health = GameController.bait_max_health
@onready var current_health = 100
@onready var health_bar = $Control/ProgressBar
@onready var size = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	size.scale.x = GameController.bait_size_scale
	size.scale.y = GameController.bait_size_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = current_health
	if current_health <= 0:
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("skeletons"):
		area.connect("damage_done", _on_area_damage_done)

func _on_area_damage_done(damage):
	current_health -= damage
