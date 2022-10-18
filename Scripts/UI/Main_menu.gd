extends Node


export (PackedScene) var game: PackedScene = load("res://Scenes/Game/Main.tscn")
export (PackedScene) var options: PackedScene


onready var menu_layer = $Menu_layer

onready var menu_buttons = $Menu_layer/Buttons
onready var start_button = $Menu_layer/Buttons/Start_button
onready var options_button = $Menu_layer/Buttons/Options_button
onready var quit_button = $Menu_layer/Buttons/Quit_button

onready var best_time = $Menu_layer/Label

onready var menu_tween = $Menu_tween
onready var options_timer = $Options_timer

onready var hover_sfx = $SFX/Hover
onready var select_sfx = $SFX/Select


func _ready():
	Engine.time_scale = 1
	start_button.grab_focus()
	Input.mouse_mode = 0
	best_time.text = "Latest time: " + GlobalVariables.latest_run

	start_button.connect("focus_entered", hover_sfx, "play")
	start_button.connect("pressed", select_sfx, "play")
	options_button.connect("focus_entered", hover_sfx, "play")
	options_button.connect("pressed", select_sfx, "play")
	quit_button.connect("focus_entered", hover_sfx, "play")
	quit_button.connect("pressed", select_sfx, "play")



func _on_Start_button_pressed():
	get_tree().change_scene_to(game)



func _on_Options_button_pressed():
	menu_tween.interpolate_property(menu_buttons, "rect_scale", Vector2(1, 1), Vector2(0, 0), 0.1, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	menu_tween.start()
	options_timer.start()



func _on_Quit_button_pressed():
	get_tree().quit()



func focus():
	start_button.grab_focus()
	menu_tween.interpolate_property(menu_buttons, "rect_scale", Vector2(0, 0), Vector2(1, 1), 0.1, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	menu_tween.start()
	menu_layer.show()



func _on_Options_timer_timeout():
	var options_inst = options.instance()
	add_child(options_inst)
	menu_layer.hide()




