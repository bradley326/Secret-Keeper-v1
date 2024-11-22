extends Node

@onready var skeleton = preload("res://scenes/skeleton.tscn")
@onready var freeze_area = preload("res://scenes/freeze.tscn")
@onready var npc = preload("res://scenes/npc.tscn")
@onready var choices_ui = preload("res://scenes/choices_ui.tscn")

@onready var closet = $Closet
@onready var ui = $UI
@onready var night_timer = $Timer

var current_npc: Node = null
var choice_count: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GameController.current_energy = GameController.total_energy
	
	#Spawn however many skeletons have been added thus far
	for n in GameController.skeletons_to_spawn:
		var new_skeleton = skeleton.instantiate()
		add_child(new_skeleton)
		new_skeleton.global_position.x = randi_range(closet.left_side, closet.right_side)
		new_skeleton.global_position.y = randi_range(closet.top_side, closet.bottom_side)
		
	if GameController.time == "day":
		#Spawn a new NPC
		var new_npc = npc.instantiate()
		add_child(new_npc)
		current_npc = new_npc
		new_npc.global_position.x = 0
		new_npc.global_position.y = 250
		new_npc.connect("npc_ready", _on_npc_ready)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("spawn"):
		#Instantiat a new skeleton and add it to a random spot in the closet
		var new_skeleton = skeleton.instantiate()
		add_child(new_skeleton)
		new_skeleton.global_position.x = randi_range(closet.left_side, closet.right_side)
		new_skeleton.global_position.y = randi_range(closet.top_side, closet.bottom_side)
			
		#new_skeleton.connect("damage_done", _on_damage_done)
	
	#Check if the left mouse button is clicked and if the freeze tool is selected
	if Input.is_action_just_pressed("left_mouse") and GameController.current_tool == GameController.Tool.FREEZE:
		print("Freezing skeletons!")
		freeze_skeletons()
		
	if choice_count >= 4:
		if GameController.time == "day":
			GameController.time = "night"
		get_tree().change_scene_to_file("res://scenes/transition.tscn")

	print(night_timer.wait_time)
	
func freeze_skeletons():
	# Create the freeze circle at the current mouse position
	var new_freeze_area = freeze_area.instantiate()
	add_child(new_freeze_area)
	new_freeze_area.global_position = get_viewport().get_mouse_position()
	
	#Subtract energy
	GameController.current_energy -= GameController.freeze_cost

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
		var new_npc = npc.instantiate()
		add_child(new_npc)
		current_npc = new_npc
		new_npc.global_position.x = 0
		new_npc.global_position.y = 250
		new_npc.connect("npc_ready", _on_npc_ready)
		
		choice_count += 1

func _on_timer_timeout():
	if GameController.time == "night":
		GameController.time = "day"
		GameController.day_count += 1
		get_tree().change_scene_to_file("res://scenes/transition.tscn")
