extends Area2D

@onready var direction_x: int
@onready var direction_y: int
@onready var attack_range = $CollisionArea

var target
var target_direction

enum State {
	SEARCHING,
	DETECTED,
	ATTACKING
}

var current_state: State = State.SEARCHING

# Called when the node enters the scene tree for the first time.
func _ready():
	get_random_direction()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		State.SEARCHING:
			_searching(delta)
		State.DETECTED:
			_detected(delta)
		State.ATTACKING:
			_attacking()
	
func _physics_process(delta):
	pass

func get_random_direction():
	#direction_x = randi_range(-1, 1)
	#direction_y = randi_range(-1, 1)
	direction_x = randi() % 2 * 2 - 1
	direction_y = randi() % 2 * 2 - 1

func _on_detect_area_area_entered(area):
	if area.is_in_group("locks"):
		print("Lock detected!")
		current_state = State.DETECTED
		target = area

func _searching(delta):
	global_position.x += 50 * delta * direction_x
	global_position.y += 50 * delta * direction_y

func _detected(delta):
	print("Found a lock and moving towards it.")
	target_direction = (target.global_position - global_position).normalized()
	global_position.x += 50 * delta * target_direction.x
	global_position.y += 50 * delta * target_direction.y

func _attacking():
	print("Near a lock. Attack!")

func _on_area_entered(area):
	if area.is_in_group("locks"):
		current_state = State.ATTACKING
