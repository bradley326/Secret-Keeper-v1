extends Control

@onready var energy_bar = $HBoxContainer3/EnergyAmount
@onready var skeleton_label = $HBoxContainer2/SkeletonLabel
@onready var gold_label = $HBoxContainer2/MoneyLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_energy()
	update_skeleton_count()
	update_gold_count()


func _on_texture_button_pressed():
	print("Activating Heal")
	GameController.current_tool = GameController.Tool.HEAL


func _on_texture_button_2_pressed():
	print("Activating Freeze")
	GameController.current_tool = GameController.Tool.FREEZE

func update_energy():
	energy_bar.value = GameController.current_energy
	
func update_skeleton_count():
	skeleton_label.text = str(GameController.skeleton_count.size())
	
func update_gold_count():
	gold_label.text = str(GameController.gold_count)
