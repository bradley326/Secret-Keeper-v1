extends Area2D

@onready var closet_shape = $CollisionShape2D

var left_side
var right_side
var top_side
var bottom_side

# Called when the node enters the scene tree for the first time.
func _ready():
	left_side = global_position.x
	right_side = global_position.x + closet_shape.get_shape().size.x
	top_side = global_position.y
	bottom_side = global_position.y + closet_shape.get_shape().size.y
	print("left side is" + str(left_side))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_exited(area):
	if area.is_in_group("skeletons"):
		#print("Skeleton exited closet!")
		if area.global_position.x < left_side:
			#print("exited left")
			area.direction_x *= -1
		if area.global_position.x > right_side:
			#print("exited right")
			area.direction_x *= -1
		if area.global_position.y < top_side:
			#print("exited top")
			area.direction_y *= -1
		if area.global_position.y > bottom_side:
			#print("exited bottom")
			area.direction_y *= -1
