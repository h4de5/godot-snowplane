extends Node

var device_id: int = 0
var device_type: String = ''
var move_vector: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent):
	control_pad(event);
#
#func set_device_id(id: int):
#	device_id = id

func control_pad(event: InputEvent):
#	print("incoming event id ", event.device, " stored ", device_id)
	if(event.device == device_id):
		# see: https://docs.godotengine.org/en/stable/tutorials/inputs/controllers_gamepads_joysticks.html#which-input-singleton-method-should-i-use
		move_vector = Input.get_vector(
			"ui_left_"+ device_type +'_'+ str(device_id), 
			"ui_right_"+ device_type +'_'+ str(device_id), 
			"ui_up_"+ device_type +'_'+ str(device_id), 
			"ui_down_"+ device_type +'_'+ str(device_id))
#		print("move_vector ", move_vector )
#		get_tree().set_input_as_handled()
