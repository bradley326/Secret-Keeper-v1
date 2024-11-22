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

@onready var minor_secrets: Array = [
	["white lie 0", 1, 20],
	["white lie 1", 1, 20],
	["white lie 2", 1, 20],
	["white lie 3", 1, 20],
	["white lie 4", 1, 20],
	["white lie 5", 1, 20],
	["white lie 6", 1, 20],
	["white lie 7", 1, 20],
	["white lie 8", 1, 20],
	["white lie 9", 1, 20],
]

@onready var medium_secrets: Array = [
	["medium secret 0", 2, 40],
	["medium secret 1", 2, 40],
	["medium secret 2", 2, 40],
	["medium secret 3", 2, 40],
	["medium secret 4", 2, 40],
	["medium secret 5", 2, 40],
	["medium secret 6", 2, 40],
	["medium secret 7", 2, 40],
	["medium secret 8", 2, 40],
	["medium secret 9", 2, 40],
]

@onready var major_secrets: Array = [
	["major secret 0", 3, 60],
	["major secret 1", 3, 60],
	["major secret 2", 3, 60],
	["major secret 3", 3, 60],
	["major secret 4", 3, 60],
	["major secret 5", 3, 60],
	["major secret 6", 3, 60],
	["major secret 7", 3, 60],
	["major secret 8", 3, 60],
	["major secret 9", 3, 60],
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
	lie_box_two_skeleton_amount.text = str(medium_secrets[random_number_two][1]) + " skeleton."
	lie_box_two_gold_amount.text = str(medium_secrets[random_number_two][2]) + " gold."

	lie_box_three_label.text = major_secrets[random_number_three][0]
	lie_box_three_skeleton_amount.text = str(major_secrets[random_number_three][1]) + " skeleton."
	lie_box_three_gold_amount.text = str(major_secrets[random_number_three][2]) + " gold."
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_one_pressed() -> void:
	GameController.gold_count += minor_secrets[random_number_one][2]
	send_skeleton_amount.emit(minor_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()

func _on_button_two_pressed() -> void:
	GameController.gold_count += medium_secrets[random_number_two][2]
	send_skeleton_amount.emit(medium_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()

func _on_button_three_pressed() -> void:
	GameController.gold_count += major_secrets[random_number_three][2]
	send_skeleton_amount.emit(major_secrets[random_number_one][1])
	spawn_new_npc.emit()
	queue_free()
