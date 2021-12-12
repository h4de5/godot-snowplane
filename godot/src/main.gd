extends Control
	

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# remove 
	get_node("players").remove_child(get_node("players/plane"))
	
	PlayerManager.start()
	
