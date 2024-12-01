extends Node

@onready var skeleton = preload("res://scenes/skeleton.tscn")
@onready var freeze_area = preload("res://scenes/freeze.tscn")
@onready var npc = preload("res://scenes/npc.tscn")
@onready var npc2 = preload("res://scenes/npc2.tscn")
@onready var npc3 = preload("res://scenes/npc3.tscn")
@onready var choices_ui = preload("res://scenes/choices_ui.tscn")
@onready var bait = preload("res://scenes/bait.tscn")
@onready var lock = preload("res://scenes/lock.tscn")
@onready var moon = preload("res://scenes/moon.tscn")

@onready var closet = $Closet
@onready var ui = $UI
@onready var night_timer = $NightTimer
@onready var energy_timer = $EnergyTimer
@onready var not_enough_energy = $NotEnoughEnergy
@onready var day_music_player = $DayMusic
@onready var night_music_player = $NightMusic
@onready var click_sound_player = $ClickSoundPlayer
@onready var spawn_npc_sound = $SpawnNPCSound

var current_npc: Node = null
var choice_count: int = 0
var destroyed_locks: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GameController.lock_counter = 0
	GameController.current_energy = GameController.total_energy
	energy_timer.wait_time = GameController.energy_regen_time
	
	if GameController.time == "night":
		var new_moon = moon.instantiate()
		add_child(new_moon)
	
	#Spawn however many skeletons have been added thus far
	for n in GameController.skeletons_to_spawn:
		var new_skeleton = skeleton.instantiate()
		add_child(new_skeleton)
		new_skeleton.global_position.x = randi_range(closet.left_side, closet.right_side)
		new_skeleton.global_position.y = randi_range(closet.top_side, closet.bottom_side)
		
	for n in GameController.locks_to_spawn.size():
		if GameController.locks_to_spawn[n][1] == true:
			var new_lock = lock.instantiate()
			add_child(new_lock)
			if n == 0:
				new_lock.global_position.x = 490
				new_lock.global_position.y = 104
			if n == 1:
				new_lock.global_position.x = 490
				new_lock.global_position.y = 160
			if n == 2:
				new_lock.global_position.x = 490
				new_lock.global_position.y = 224
			if n == 3:
				new_lock.global_position.x = 490
				new_lock.global_position.y = 288
		GameController.lock_counter += 1
		
	if GameController.time == "day":
		#Spawn a new NPC
		var new_npc = npc.instantiate()
		add_child(new_npc)
		current_npc = new_npc
		new_npc.global_position.x = 0
		new_npc.global_position.y = 352
		new_npc.connect("npc_ready", _on_npc_ready)
		spawn_npc_sound.play()
		
	if GameController.time == "day":
		day_music_player.play()
	elif GameController.time == "night":
		night_music_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Check if all locks have been destroyed
	check_game_over()
	
	#Check if the left mouse button is clicked and if the freeze tool is selected
	if Input.is_action_just_pressed("left_mouse") and GameController.current_tool == GameController.Tool.FREEZE and GameController.time == "night":
		var within_bounds: Vector2 = get_viewport().get_mouse_position()
		if within_bounds.x >= closet.left_side and within_bounds.x <= closet.right_side:
			if within_bounds.y >= closet.top_side and within_bounds.y <= closet.bottom_side:
				if GameController.current_energy >= GameController.freeze_tool_energy_cost:
					freeze_skeletons()
				elif GameController.current_energy <= GameController.freeze_tool_energy_cost:
					GameController.not_enough_energy = true

	if Input.is_action_just_pressed("left_mouse") and GameController.current_tool == GameController.Tool.BAIT and GameController.time == "night":
		var within_bounds: Vector2 = get_viewport().get_mouse_position()
		if within_bounds.x >= closet.left_side and within_bounds.x <= closet.right_side:
			if within_bounds.y >= closet.top_side and within_bounds.y <= closet.bottom_side:
				if GameController.current_energy >= GameController.bait_energy_cost:
					spawn_bait()
				elif GameController.current_energy < GameController.bait_energy_cost:
					GameController.not_enough_energy = true
				
	if GameController.current_energy >= GameController.max_energy:
		GameController.current_energy = GameController.max_energy
	
	if GameController.current_energy <= GameController.min_energy:
		GameController.current_energy = GameController.min_energy
		
	if choice_count >= 4:
		if GameController.time == "day":
			GameController.time = "night"
		get_tree().change_scene_to_file("res://scenes/transition.tscn")
	
func freeze_skeletons():
	# Create the freeze circle at the current mouse position
	var new_freeze_area = freeze_area.instantiate()
	add_child(new_freeze_area)
	new_freeze_area.global_position = get_viewport().get_mouse_position()
	
	#Subtract energy
	GameController.current_energy -= GameController.freeze_tool_energy_cost

func _on_send_skeleton_amount(amount):
	for number in amount:
		#Instantiat a new skeleton and add it to a random spot in the closet
		var new_skeleton = skeleton.instantiate()
		add_child(new_skeleton)
		new_skeleton.global_position.x = randi_range(closet.left_side, closet.right_side)
		new_skeleton.global_position.y = randi_range(closet.top_side, closet.bottom_side)
		
	GameController.skeletons_to_spawn += amount

func _on_npc_ready():
	if GameController.time == "day":
		var new_choices_ui = choices_ui.instantiate()
		add_child(new_choices_ui)
		new_choices_ui.connect("send_skeleton_amount", _on_send_skeleton_amount)
		new_choices_ui.connect("spawn_new_npc", _on_spawn_new_npc)
	
func _on_spawn_new_npc():
	#Spawn a new NPC
	if GameController.time == "day":
		current_npc.queue_free()
		var random_npc = randi_range(1, 3)
		var new_npc
		if random_npc == 1:
			new_npc = npc.instantiate()
		elif random_npc == 2:
			new_npc = npc2.instantiate()
		elif random_npc == 3:
			new_npc = npc3.instantiate()
		add_child(new_npc)
		current_npc = new_npc
		new_npc.global_position.x = 0
		new_npc.global_position.y = 352
		new_npc.connect("npc_ready", _on_npc_ready)
		
		choice_count += 1
		
		spawn_npc_sound.play()

func _on_energy_timer_timeout():
	if GameController.time == "night":
		GameController.current_energy += (GameController.energy_regen_amount_percent * GameController.total_energy)

func _on_night_timer_timeout():
	if GameController.time == "night":
		GameController.time = "day"
		GameController.day_count += 1
		get_tree().change_scene_to_file("res://scenes/transition.tscn")

func spawn_bait():
	var new_bait = bait.instantiate()
	add_child(new_bait)
	new_bait.global_position = get_viewport().get_mouse_position()
	
	GameController.current_energy -= GameController.bait_energy_cost
	
func check_game_over():
	if GameController.destroyed_locks >= 4:
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
