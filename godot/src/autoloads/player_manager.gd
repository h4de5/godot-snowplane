extends Node

var _playernode = preload("res://src/plane.tscn")
var _inputnode = preload("res://src/interfaces/input.gd");

func start():
	# react to any controller changes
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
#	Input.connect("key_pressed")
	
	# add a new player for each connected joypad
	for joypad_id in Input.get_connected_joypads():
		if(!player_exists(joypad_id, 'joypad')):
			print("starting with player ", name, " # ", str(joypad_id) )
			add_player_to_game(joypad_id, 'joypad')
		
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			remove_player_from_game(0, 'keyboard')
		if event.pressed and event.scancode == KEY_ENTER:
			if(!player_exists(0, 'keyboard')):
				add_player_to_game(0, 'keyboard')

# If controler is connected or disconnected add ore remove a player
func _joy_connection_changed(device: int, connected: bool, name:  String = "new", guid:  String = "X1234" ):
	if connected:
		print("new player ", name, " # ", str(device) )
		add_player_to_game(device, 'joypad')
	else:
		print("player left ", name, " # ", str(device) )
		remove_player_from_game(device, 'joypad')


func player_exists(player_id: int, device_type: String):
	var node = get_tree().current_scene.get_node("players/plane_"+ device_type +'_'+ str(player_id))
	return node != null

func add_player_to_game(player_id: int, device_type: String):
	
#	var playernode = _playernode.duplicate(DUPLICATE_SCRIPTS)
#	var inputnode = _inputnode.duplicate(DUPLICATE_SCRIPTS)
#	var inputnode = _playernode.get('input')
	var playernode = _playernode.instance();
	var inputnode = Node.new()
	inputnode.set_script(_inputnode)

	playernode.name = "plane_"+ device_type +'_'+ str(player_id)
	playernode.player_id = player_id
	playernode.device_type = device_type

	inputnode.name = "input"
	
	playernode.add_child(inputnode)
	get_tree().current_scene.get_node("players").add_child(playernode)

	print("created new player_id with ", player_id)
	
func remove_player_from_game(player_id: int, device_type: String):
	var node = get_tree().current_scene.get_node("players/plane_"+ device_type +'_'+ str(player_id))
	if(node):
		get_tree().current_scene.get_node("players").remove_child(node)
	else:
		print("Cannot remove "+ device_type +" player #"+ str(player_id))

