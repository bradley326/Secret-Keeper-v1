extends Control

@onready var lie_box_one = $VBoxContainer/LieOneBox
@onready var lie_box_one_label = $VBoxContainer/LieOneBox/LieText
@onready var lie_box_one_skeleton_amount = $VBoxContainer/LieOneBox/SkeletonAmount
@onready var lie_box_one_gold_amount = $VBoxContainer/LieOneBox/GoldAmount

@onready var lie_box_two = $VBoxContainer/LieTwoBox
@onready var lie_box_two_label = $VBoxContainer/LieTwoBox/LieText
@onready var lie_box_two_skeleton_amount = $VBoxContainer/LieTwoBox/SkeletonAmount
@onready var lie_box_two_gold_amount = $VBoxContainer/LieTwoBox/GoldAmount

@onready var lie_box_three = $VBoxContainer/LieThreeBox
@onready var lie_box_three_label = $VBoxContainer/LieThreeBox/LieText
@onready var lie_box_three_skeleton_amount = $VBoxContainer/LieThreeBox/SkeletonAmount
@onready var lie_box_three_gold_amount = $VBoxContainer/LieThreeBox/GoldAmount

@onready var coin_sound_player = $CoinSoundPlayer

@onready var minor_secrets: Array = [
	["My spouse DOES look fat in their new clothes.", 1, 20],
	["I said I liked my friend's disgusting pie.", 1, 20],
	["I wasn't busy. I was just lazy.", 1, 20],
	["My horse doesn't have diabetes.", 1, 20],
	["I could pay my friend back, but I don't want to.", 1, 20],
	["I wasn't sick. I just didn't want to work.", 1, 20],
	["I said my friend's haircut is great. It isn't.", 1, 20],
	["They thought the onions were caramalized. They were burnt.", 1, 20],
	["I blamed my daughter for eating the last cookie.", 1, 20],
	["Instead of the gym, I sit in a pub all morning.", 1, 20],
]

@onready var medium_secrets: Array = [
	["I spit in all the food I serve.", 2, 40],
	["I break people's windows at night.", 2, 40],
	["I don't forget people's birthdays. I ignore them.", 2, 40],
	["I go to nice museums just to stink up the bathrooms.", 2, 40],
	["I always walk through mud before entering my in-law's house.", 2, 40],
	["I told them it was vegan, but it was pure meat.", 2, 40],
	["I get joy out of putting turtles on their shells.", 2, 40],
	["I hid a rotten fish in my brother's house.", 2, 40],
	["Those donuts at work? I found them in the dumpster.", 2, 40],
	["I'm excited by eating my coworkers' lunches.", 2, 40],
]

@onready var major_secrets: Array = [
	["The neighbor's cat didn't run away.", 3, 60],
	["I'm having three affairs.", 3, 60],
	["I have a secret family three towns over.", 3, 60],
	["The fire wasn't an accident. I needed the insurance money.", 3, 60],
	["I wish they'd bring back public executions.", 3, 60],
	["I gave the neighbor's dog tainted meat.", 3, 60],
	["I file false reports with the sheriff to get people in trouble.", 3, 60],
	["The fire wasn't an accident. I needed the insurance money.", 3, 60],
	["I have a secret family three towns over.", 3, 60],
	["I'm cheating on my mistress.", 3, 60],
]

var random_number_one = randi_range(0, 9)
var random_number_two = randi_range(0, 9)
var random_number_three = randi_range(0, 9)

signal send_skeleton_amount(amount: int)
signal spawn_new_npc

# Called when the node enters the scene tree for the first time.
func _ready():
	random_number_one = randi_range(0, 9)
	random_number_two = randi_range(0, 9)
	random_number_three = randi_range(0, 9)
	lie_box_one_label.text = minor_secrets[random_number_one][0]
	lie_box_one_skeleton_amount.text = str(minor_secrets[random_number_one][1]) + " skeleton."
	lie_box_one_gold_amount.text = str(minor_secrets[random_number_one][2]) + " gold."
	
	lie_box_two_label.text = medium_secrets[random_number_two][0]
	lie_box_two_skeleton_amount.text = str(medium_secrets[random_number_two][1]) + " skeletons."
	lie_box_two_gold_amount.text = str(medium_secrets[random_number_two][2]) + " gold."

	lie_box_three_label.text = major_secrets[random_number_three][0]
	lie_box_three_skeleton_amount.text = str(major_secrets[random_number_three][1]) + " skeletons."
	lie_box_three_gold_amount.text = str(major_secrets[random_number_three][2]) + " gold."
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_one_pressed() -> void:
	GameController.gold_count += minor_secrets[random_number_one][2]
	send_skeleton_amount.emit(minor_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()
	coin_sound_player.play()

func _on_button_two_pressed() -> void:
	coin_sound_player.play()
	GameController.gold_count += medium_secrets[random_number_two][2]
	send_skeleton_amount.emit(medium_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()

func _on_button_three_pressed() -> void:
	coin_sound_player.play()
	GameController.gold_count += major_secrets[random_number_three][2]
	send_skeleton_amount.emit(major_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()
