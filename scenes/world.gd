extends Node

@onready var skeleton = preload("res://scenes/skeleton.tscn")

@onready var closet = $Closet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("spawn"):
		print("Spawning a new skeleton")
		var new_skeleton = skeleton.instantiate()
		add_child(new_skeleton)
		new_skeleton.global_position.x = randi_range(closet.left_side, closet.right_side)
		new_skeleton.global_position.y = randi_range(closet.top_side, closet.bottom_side)
		new_skeleton.connect("damage_done", _on_damage_done)

func _on_damage_done(damage):
	print(damage)
		
