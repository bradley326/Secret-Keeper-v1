extends Node

@onready var total_energy: int = 100
@onready var current_energy: int
@onready var max_energy: int = 100
@onready var min_energy: int = 0
@onready var energy_regen_amount_percent: float = .01
@onready var energy_regen_time: int = 1
@onready var time: String = "day"
@onready var not_enough_energy: bool = false

@onready var gold_count: int = 0
@onready var skeleton_count: Array
@onready var day_count: int = 1
@onready var skeletons_to_spawn: int = 0
@onready var locks_to_spawn: Array = [["lock 1", true], ["lock 2", true], ["lock 3", true], ["lock 4", true]]
@onready var lock_counter: int = 0
@onready var destroyed_locks: int = 0

#Lock variables
#Lock health amount upgrades
@onready var lock_max_health: int = 100
@onready var lock_health_upgrade_amount: int = 50
@onready var lock_health_upgrade_cost: int = 100
@onready var lock_health_upgrade_level: int = 1
#Lock health regen upgrades
@onready var lock_health_regen_amount: int = 0
@onready var lock_health_regen_increase: int = 5
@onready var lock_health_regen_cost: int = 200
@onready var lock_health_regen_level: int = 1

#Tool variables
#Repair tool variables
#Repair tool energy cost reduction
@onready var repair_tool_heal_energy_cost: int = 5
@onready var repair_tool_heal_cost: int = 100
@onready var repair_tool_heal_energy_decrease: int = 1
@onready var repair_tool_heal_energy_level: int = 1
#Repair tool heal amount increase
@onready var repair_tool_heal_amount: int = 20
@onready var repair_tool_heal_increase: int = 10
@onready var repair_tool_heal_level: int = 1

#Freeze tool variables
#Freeze tool energy cost reduction
@onready var freeze_tool_energy_cost: int = 30
@onready var freeze_tool_energy_gold_cost: int = 200
@onready var freeze_tool_energy_decrease: int = 5
@onready var freeze_tool_energy_level: int = 1
#Freeze tool freeze duration
@onready var freeze_tool_duration_gold_cost: int = 300
@onready var freeze_tool_freeze_duration: int = 5
@onready var freeze_tool_freeze_duration_increase: int = 2
@onready var freeze_tool_duration_level: int = 1
#Freeze tool size
@onready var freeze_tool_size_gold_cost: int = 300
@onready var freeze_tool_size_increase: float = .25
@onready var freeze_tool_size_scale: float = 1.0
@onready var freeze_tool_size_level: int = 1

#Bait variables
#Bait energy cost reduction
@onready var bait_energy_cost: int = 25
@onready var bait_energy_cost_decrease: int = 3
@onready var bait_energy_gold_cost: int = 200
@onready var bait_energy_cost_level: int = 1
#Bait size
@onready var bait_size_gold_cost: int = 50
@onready var bait_size_increase: float = .25
@onready var bait_size_scale: float = 1.0
@onready var bait_size_level: int = 1
#Bait max health
@onready var bait_max_health: int = 100
@onready var bait_max_health_gold_cost: int = 300
@onready var bait_max_health_increase: int = 50
@onready var bait_max_health_level: int = 1

enum Tool {
	HEAL,
	FREEZE,
	BAIT
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
		Tool.BAIT:
			_bait()
	
	skeleton_count = get_tree().get_nodes_in_group("skeletons")
	
func _heal():
	pass
	
func _freeze():
	pass
	
func _bait():
	pass
