extends Control

@onready var energy_bar = $HBoxContainer3/EnergyAmount
@onready var skeleton_label = $HBoxContainer2/SkeletonLabel
@onready var gold_label = $HBoxContainer2/MoneyLabel
@onready var click_sound_player = $ClickSoundPlayer
@onready var upgrade_ui = preload("res://scenes/ui_upgrades.tscn")
@onready var upgrade_ui_visible: bool
@onready var new_upgrade_ui = upgrade_ui.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(new_upgrade_ui)
	new_upgrade_ui.global_position.x = -500
	new_upgrade_ui.global_position.y = -500
	upgrade_ui_visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_energy()
	update_skeleton_count()
	update_gold_count()


func _on_texture_button_pressed():
	GameController.current_tool = GameController.Tool.HEAL
	click_sound_player.play()


func _on_texture_button_2_pressed():
	GameController.current_tool = GameController.Tool.FREEZE
	click_sound_player.play()

func _on_texture_button_3_pressed():
	GameController.current_tool = GameController.Tool.BAIT
	click_sound_player.play()

func update_energy():
	energy_bar.value = GameController.current_energy
	
func update_skeleton_count():
	skeleton_label.text = str(GameController.skeleton_count.size())
	
func update_gold_count():
	gold_label.text = str(GameController.gold_count)

func _on_upgrade_button_pressed() -> void:
	click_sound_player.play()
	if upgrade_ui_visible == false:
		new_upgrade_ui.global_position.x = 304
		new_upgrade_ui.global_position.y = 360
		upgrade_ui_visible = true
	elif upgrade_ui_visible == true:
		new_upgrade_ui.global_position.x = -500
		new_upgrade_ui.global_position.y = -500
		upgrade_ui_visible = false
	
