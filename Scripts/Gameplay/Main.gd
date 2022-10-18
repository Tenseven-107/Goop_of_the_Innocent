extends Node2D


export (PackedScene) var pause: PackedScene = load("res://Prefabs/UI/Pause_menu.tscn")

onready var game_cam = $Game_camera
onready var hunter_container = $World/Enemies/Hunter_container
onready var circle = $World/Important/Sacrifical_circle
onready var hud = $Hud

var player_node = null


# Set up
func _ready():
	randomize()
	Engine.time_scale = 1
	Input.mouse_mode = 3

	# Setting camera to player pos
	player_node = get_tree().get_nodes_in_group("Player")
	for player in player_node:
		player.set_cam(game_cam.get_path())

		# Give player to objects
		hunter_container.initialize(player)
		circle.initialize(player)
		hud.initialize(player)


func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		var pause_inst = pause.instance()
		add_child(pause_inst)
