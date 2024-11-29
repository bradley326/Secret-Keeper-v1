extends Area2D

@onready var direction_x: int
@onready var direction_y: int
@onready var attack_range = $CollisionArea
@onready var attack_timer = $Timer
@onready var freeze_timer = $FreezeTimer

var target
var target_direction
var max_damage = 10
var min_damage = 2
var previous_state: State = State.SEARCHING

signal damage_done(damage: int)

enum State {
	SEARCHING,
	DETECTED,
	ATTACKING,
	FROZEN
}

var current_state: State = State.SEARCHING

# Called when the node enters the scene tree for the first time.
func _ready():
	get_random_direction()
	freeze_timer.wait_time = GameController.freeze_tool_freeze_duration
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		State.SEARCHING:
			_searching(delta)
		State.DETECTED:
			_detected(delta)
		State.ATTACKING:
			_attacking()
		State.FROZEN:
			_frozen()
	
func _physics_process(delta):
	pass

func get_random_direction():
	direction_x = randi() % 2 * 2 - 1
	direction_y = randi() % 2 * 2 - 1

func _on_detect_area_area_entered(area):
	if area.is_in_group("bait") and GameController.time == "night":
		current_state = State.DETECTED
		target = area
	elif area.is_in_group("locks") and GameController.time == "night":
		current_state = State.DETECTED
		target = area

func _searching(delta):
	global_position.x += 30 * delta * direction_x
	global_position.y += 30 * delta * direction_y

func _detected(delta):
	if target != null:
		target_direction = (target.global_position - global_position).normalized()
		global_position.x += 70 * delta * target_direction.x
		global_position.y += 70 * delta * target_direction.y

func _attacking():
	if target == null:
		current_state = State.SEARCHING
		#if target.current_health <= 0:


func _frozen():
	pass

func _on_area_entered(area):
	if (area.is_in_group("locks") or area.is_in_group("bait")) and GameController.time == "night":
		current_state = State.ATTACKING
		attack_timer.start()
	if area.is_in_group("freeze"):
		if current_state == State.ATTACKING:
			attack_timer.stop()
		previous_state = current_state
		current_state = State.FROZEN
		freeze_timer.start()

func _on_timer_timeout():
	var damage = randi_range(min_damage, max_damage)
	damage_done.emit(damage)

func _on_freeze_timer_timeout():
	current_state = previous_state
	if current_state == State.ATTACKING:
		attack_timer.start()
	if current_state == State.FROZEN:
		current_state = State.SEARCHING
	
