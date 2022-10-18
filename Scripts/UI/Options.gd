extends CanvasLayer



onready var menu_tween = $Tween

onready var buttons = $Buttons
onready var check_box = $Buttons/CheckBox
onready var back_button = $Buttons/Back_button

onready var exit_timer = $Exit_timer

onready var hover_sfx = $SFX/Hover
onready var select_sfx = $SFX/Select


func _ready():
	menu_tween.interpolate_property(buttons, "rect_scale", Vector2(0, 0), Vector2(1, 1), 0.1, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	menu_tween.start()

	check_box.pressed = OS.window_fullscreen
	back_button.grab_focus()

	check_box.connect("focus_entered", hover_sfx, "play")
	check_box.connect("pressed", select_sfx, "play")
	back_button.connect("focus_entered", hover_sfx, "play")
	back_button.connect("pressed", select_sfx, "play")



func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false



func _on_Back_button_pressed():
	menu_tween.interpolate_property(buttons, "rect_scale", Vector2(1, 1), Vector2(0, 0), 0.1, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	menu_tween.start()
	exit_timer.start()


func _on_Exit_timer_timeout():
	get_parent().focus()
	queue_free()
