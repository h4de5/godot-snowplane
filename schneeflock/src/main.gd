extends Control

var _playernode: Node
var _inputnode: Node

func _init():
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
#
	_playernode = get_node("players/plane")
	_inputnode = get_node("players/plane/input")

#	get_node("players").remove_child(get_node("players/plane"))
	get_node("players").remove_child(get_node("players/plane"))

	for joypad_id in Input.get_connected_joypads():
		add_player_to_game(joypad_id)
		

func add_player_to_game(player_id: int):
	
	var playernode = _playernode.duplicate(DUPLICATE_SCRIPTS)
	var inputnode = _inputnode.duplicate(DUPLICATE_SCRIPTS)
#	var inputnode = _playernode.get('input')


#	playernode.remove_child(playernode.get("input"))
	
	playernode.name = "plane_"+ str(player_id)
	playernode.player_id = player_id

	inputnode.name = "input_"+ str(player_id)
	inputnode.device_id = player_id

	playernode.add_child(inputnode)
	get_node("players").add_child(playernode)

	print("created player_id ", player_id)
	
func remove_player_from_game(player_id: int):
	get_node("players").remove_child(get_node("players/plane_" + str(player_id)))

func _joy_connection_changed(device: int, connected: bool, name:  String, guid:  String ):
	if connected:
		print("new player ", name, " # ", str(device) )
		add_player_to_game(device)
	else:
		print("player left ", name, " # ", str(device) )
		remove_player_from_game(device)
	
