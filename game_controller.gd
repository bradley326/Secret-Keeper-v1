extends Node

@onready var total_energy: int = 50
@onready var current_energy: int
@onready var freeze_duration: int  = 5
@onready var time: String = "day"

@onready var heal_cost = 5
@onready var freeze_cost = 25

@onready var gold_count: int = 0
@onready var skeleton_count: Array
@onready var day_count: int = 1
@onready var skeletons_to_spawn: int = 0

enum Tool {
	HEAL,
	FREEZE
}

var current_tool: Tool = Tool.HEAL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_tool:
		Tool.HEAL:
			_heal()
		Tool.FREEZE:
			_freeze()
	
	skeleton_count = get_tree().get_nodes_in_group("skeletons")
	
func _heal():
	pass
	
func _freeze():
	pass
