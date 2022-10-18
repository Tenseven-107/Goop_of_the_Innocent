extends CanvasLayer


export (PackedScene) var main_menu: PackedScene = load("res://Scenes/Game/Main_menu.tscn")

onready var resume = $VBoxContainer/Resume_button
onready var quit = $VBoxContainer/Quit_button

onready var hover_sfx = $SFX/Hover
onready var select_sfx = $SFX/Select


func _ready():
	get_tree().paused = true
	Engine.time_scale = 1

	resume.grab_focus()
	Input.mouse_mode = 0

	resume.connect("focus_entered", hover_sfx, "play")
	resume.connect("pressed", select_sfx, "play")
	quit.connect("focus_entered", hover_sfx, "play")
	quit.connect("pressed", select_sfx, "play")


func _on_Resume_button_pressed():
	get_tree().paused = false
	Input.mouse_mode = 3
	queue_free()


func _on_Quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(main_menu)
