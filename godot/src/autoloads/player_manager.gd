extends Node

var _playernode = preload("res://src/plane.tscn")
var _inputnode = preload("res://src/interfaces/input.gd");

func start():
	# react to any controller changes
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	
	# add a new player for each connected joypad
	for joypad_id in Input.get_connected_joypads():
		add_player_to_game(joypad_id)

# If controler is connected or disconnected add ore remove a player
func _joy_connection_changed(device: int, connected: bool, name:  String = "new", guid:  String = "X1234" ):
	if connected:
		print("new player ", name, " # ", str(device) )
		add_player_to_game(device)
	else:
		print("player left ", name, " # ", str(device) )
		remove_player_from_game(device)

# create a new player
func add_player_to_game(player_id: int):
	
#	var playernode = _playernode.duplicate(DUPLICATE_SCRIPTS)
#	var inputnode = _inputnode.duplicate(DUPLICATE_SCRIPTS)
#	var inputnode = _playernode.get('input')
	var playernode = _playernode.instance();
	var inputnode = Node.new()
	inputnode.set_script(_inputnode)

	playernode.name = "plane_"+ str(player_id)
	playernode.player_id = player_id

	inputnode.name = "input"
	inputnode.device_id = player_id

	playernode.add_child(inputnode)
	get_tree().current_scene.get_node("players").add_child(playernode)

	print("created new player_id with ", player_id)
	
func remove_player_from_game(player_id: int):
	get_node("players").remove_child(get_node("players/plane_" + str(player_id)))

