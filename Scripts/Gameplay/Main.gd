extends Node2D


onready var game_cam = $Game_camera

var player_node = null


# Set up
func _ready():
	randomize()

	# Setting camera to player pos
	player_node = get_tree().get_nodes_in_group("Player")
	for player in player_node:
		player.set_cam(game_cam.get_path())
