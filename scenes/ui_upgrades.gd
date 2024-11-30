extends Control

@onready var click_sound_player = $ClickSoundPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lock_health_button_pressed() -> void:
	if GameController.gold_count >= GameController.lock_health_upgrade_cost and GameController.lock_health_upgrade_level < 4:
		GameController.lock_max_health += GameController.lock_health_upgrade_amount
		GameController.gold_count -= GameController.lock_health_upgrade_cost
		GameController.lock_health_upgrade_level += 1
		click_sound_player.play()
		
func _on_lock_health_regen_pressed() -> void:
	if GameController.gold_count >= GameController.lock_health_regen_cost and GameController.lock_health_regen_level < 4:
		GameController.lock_health_regen_amount += GameController.lock_health_regen_increase
		GameController.gold_count -= GameController.lock_health_regen_cost
		GameController.lock_health_regen_level += 1
		click_sound_player.play()
		
func _on_repair_tool_energy_cost_pressed() -> void:
	if GameController.gold_count >= GameController.repair_tool_heal_cost and GameController.repair_tool_heal_energy_level < 4:
		GameController.repair_tool_heal_energy_cost -= GameController.repair_tool_heal_energy_decrease
		GameController.gold_count -= GameController.repair_tool_heal_cost
		GameController.repair_tool_heal_energy_level += 1
		click_sound_player.play()
		
func _on_repair_tool_heal_amount_pressed():
	if GameController.gold_count >= GameController.repair_tool_heal_cost and GameController.repair_tool_heal_level < 4:
		GameController.repair_tool_heal_amount += GameController.repair_tool_heal_increase
		GameController.gold_count -= GameController.repair_tool_heal_cost
		GameController.repair_tool_heal_level += 1
		click_sound_player.play()
		
func _on_freeze_tool_energy_cost_pressed():
	if GameController.gold_count >= GameController.freeze_tool_energy_gold_cost and GameController.freeze_tool_energy_level < 4:
		GameController.freeze_tool_energy_cost -= GameController.freeze_tool_energy_decrease
		GameController.gold_count -= GameController.freeze_tool_energy_gold_cost
		GameController.freeze_tool_energy_level += 1
		click_sound_player.play()
		
func _on_freeze_tool_freeze_duration_pressed():
	if GameController.gold_count >= GameController.freeze_tool_duration_gold_cost and GameController.freeze_tool_duration_level < 4:
		GameController.freeze_tool_freeze_duration += GameController.freeze_tool_freeze_duration_increase
		GameController.gold_count -= GameController.freeze_tool_duration_gold_cost
		GameController.freeze_tool_duration_level += 1
		click_sound_player.play()
		
func _on_freeze_tool_freeze_radius_pressed():
	if GameController.gold_count >= GameController.freeze_tool_size_gold_cost and GameController.freeze_tool_size_level < 4:
		GameController.freeze_tool_size_scale += GameController.freeze_tool_size_increase
		GameController.gold_count -= GameController.freeze_tool_size_gold_cost
		GameController.freeze_tool_size_level += 1
		click_sound_player.play()
		
func _on_bait_energy_cost_pressed():
	if GameController.gold_count >= GameController.bait_energy_gold_cost and GameController.bait_energy_cost_level < 4:
		GameController.bait_energy_cost -= GameController.bait_energy_cost_decrease
		GameController.gold_count -= GameController.bait_energy_gold_cost
		GameController.bait_energy_cost_level += 1
		click_sound_player.play()

func _on_bait_health_pressed():
	if GameController.gold_count >= GameController.bait_max_health_gold_cost and GameController.bait_max_health_level < 4:
		GameController.bait_max_health += GameController.bait_max_health_increase
		GameController.gold_count -= GameController.bait_max_health_gold_cost
		GameController.bait_max_health_level += 1	
		click_sound_player.play()
