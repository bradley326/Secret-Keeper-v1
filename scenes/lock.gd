extends Area2D

@onready var max_health = GameController.lock_max_health
@onready var current_health = GameController.lock_max_health
@onready var health_bar = $Control/ProgressBar
@onready var not_enough_energy = $NotEnoughEnergy
@onready var sound_effect = $SoundEffect
@onready var lock_number: int

# Called when the node enters the scene tree for the first time.
func _ready():
	lock_number = GameController.lock_counter
	print("spawning lock number " + str(lock_number))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_bar.value = current_health
	if current_health > GameController.lock_max_health:
		current_health = GameController.lock_max_health
	if current_health <= 0:
		GameController.locks_to_spawn[lock_number][1] = false
		GameController.destroyed_locks += 1
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("skeletons"):
		area.connect("damage_done", _on_area_damage_done)

func _on_area_damage_done(damage):
	current_health -= damage

func _on_mouse_entered() -> void:
	scale = Vector2(1.5, 1.5)
	
func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and GameController.current_tool == GameController.Tool.HEAL and GameController.time == "night":
			if GameController.current_energy >= GameController.repair_tool_heal_energy_cost:
				if event.pressed:
					sound_effect.play()
					current_health += GameController.repair_tool_heal_amount
					GameController.current_energy -= GameController.repair_tool_heal_energy_cost
			elif GameController.current_energy < GameController.repair_tool_heal_energy_cost:
				GameController.not_enough_energy = true

func _on_regen_timer_timeout() -> void:
	current_health += GameController.lock_health_regen_amount
