extends Node

var player_id: int = 0

var player_colors = ["green", "blue", "red", "yellow"]

func _enter_tree():
	get_node("input").device_id = player_id
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("KinematicBody2D/CollisionPolygon2D/AnimatedSprite").set_animation(player_colors[player_id])
	get_node("input").device_id = player_id

func _physics_process(delta):
#	print("vector ", get_node("input").move_vector)
	move(get_node("input").move_vector * delta * 60 * 4)

func move(vector: Vector2):
	
	if(vector != Vector2(0,0)):
#		print("vector ", vector)
		var plane = get_node("KinematicBody2D").move_and_collide(vector)
		turn(vector.angle_to_point(Vector2(0,0)))

func turn(angle: float):
	var plane = get_node("KinematicBody2D").set_rotation(angle)
