extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# prepare inputs for up to 4 controllers
	create_input_map_keyboard(0)
	for device_id in [0,1,2,3]:
		create_input_map_controller(device_id)
		
		
func create_input_map_keyboard(device_id: int):
	var device_type = 'keyboard'
	var input_map = {
		"ui_left_"+ device_type +'_'+ str(device_id): {
			"action": "ui_left_"+ device_type +'_'+ str(device_id),
			"scancodes_key": [KEY_LEFT, KEY_A],
#			"scancodes_mouse": [],
		},
		"ui_right_"+ device_type +'_'+ str(device_id): {
			"action": "ui_right_"+ device_type +'_'+ str(device_id),
			"scancodes_key": [KEY_RIGHT, KEY_D],
#			"scancodes_mouse": [],
		},
		"ui_up_"+ device_type +'_'+ str(device_id): {
			"action": "ui_up_"+ device_type +'_'+ str(device_id),
			"scancodes_key": [KEY_UP, KEY_W,],
#			"scancodes_mouse": [],
		},
		"ui_down_"+ device_type +'_'+ str(device_id): {
			"action": "ui_down_"+ device_type +'_'+ str(device_id),
			"scancodes_key": [KEY_DOWN, KEY_S],
#			"scancodes_mouse": [],
		},
	}
	#	"ui_accept": {
	#		"action": global.actions.fire,
	#		"scancodes_key": [KEY_SHIFT, KEY_CONTROL],
	#		"scancodes_dpad": [JOY_BUTTON_0],
	#		"scancodes_mouse": [BUTTON_XBUTTON1],
	#	},
	#	"ui_select": {
	#		"action": global.actions.use,
	#		"scancodes_key": [KEY_ENTER, KEY_TAB],
	#		"scancodes_dpad": [JOY_BUTTON_3],
	#		"scancodes_mouse": [BUTTON_XBUTTON2],
	#	},

	for action_identifier in input_map:
		InputMap.add_action(action_identifier)
		
		for scancodes_key in input_map[action_identifier].scancodes_key:
			var evMotion = InputEventKey.new()
			evMotion.set_device(device_id)
			evMotion.set_scancode(scancodes_key)
			InputMap.action_add_event(action_identifier, evMotion)
		
func create_input_map_controller(device_id: int):
	var device_type = 'joypad'
	var input_map = {
		"ui_left_"+str(device_id): {
			"action": "ui_left_"+ device_type +'_'+ str(device_id),
#			"scancodes_key": [KEY_LEFT, KEY_A],
			"scancodes_dpad": [JOY_DPAD_LEFT, JOY_BUTTON_14],
			"axis": 0,
			"axis_value": -1,
#			"scancodes_mouse": [],
		},
		"ui_right_"+str(device_id): {
			"action": "ui_right_"+ device_type +'_'+ str(device_id),
#			"scancodes_key": [KEY_RIGHT, KEY_D],
			"scancodes_dpad": [JOY_DPAD_RIGHT, JOY_BUTTON_15],
			"axis": 0,
			"axis_value": 1,
#			"scancodes_mouse": [],
		},
		"ui_up_"+str(device_id): {
			"action": "ui_up_"+ device_type +'_'+ str(device_id),
#			"scancodes_key": [KEY_UP, KEY_W,],
			"scancodes_dpad": [JOY_DPAD_UP, JOY_BUTTON_12],
			"axis": 1,
			"axis_value": -1,
#			"scancodes_mouse": [],
		},
		"ui_down_"+str(device_id): {
			"action": "ui_down_"+ device_type +'_'+ str(device_id),
#			"scancodes_key": [KEY_DOWN, KEY_S],
			"scancodes_dpad": [JOY_DPAD_DOWN, JOY_BUTTON_13],
			"axis": 1,
			"axis_value": 1,
#			"scancodes_mouse": [],
		},
	}
	#	"ui_accept": {
	#		"action": global.actions.fire,
	#		"scancodes_key": [KEY_SHIFT, KEY_CONTROL],
	#		"scancodes_dpad": [JOY_BUTTON_0],
	#		"scancodes_mouse": [BUTTON_XBUTTON1],
	#	},
	#	"ui_select": {
	#		"action": global.actions.use,
	#		"scancodes_key": [KEY_ENTER, KEY_TAB],
	#		"scancodes_dpad": [JOY_BUTTON_3],
	#		"scancodes_mouse": [BUTTON_XBUTTON2],
	#	},

	for action_identifier in input_map:
		InputMap.add_action(action_identifier)
		var evMotion = InputEventJoypadMotion.new()
		evMotion.set_axis(input_map[action_identifier].axis)
		evMotion.set_device(device_id)
		evMotion.set_axis_value(input_map[action_identifier].axis_value)
		InputMap.action_add_event(action_identifier, evMotion)
		
		# only takes first defined key for joypad buttons
		var evCursor = InputEventJoypadButton.new()
		evCursor.set_button_index(input_map[action_identifier].scancodes_dpad[0])
		evCursor.set_device(device_id)
		
		InputMap.action_add_event(action_identifier, evCursor)
			
