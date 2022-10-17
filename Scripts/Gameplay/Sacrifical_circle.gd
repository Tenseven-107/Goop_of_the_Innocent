extends YSort


onready var sacriffice_counter = $Circle/Label
onready var game_timer = $Game_timer
onready var ending_timer = $Ending_timer

onready var ambience = $SFX/Circle_ambience

onready var talisman_anims = $Talisman/Talisman_anims
onready var anims = $Anims

var player = null

var sacrifices: int = 0
export (int) var needed_sacrifices: int = 13

export (bool) var anim_loop: bool = true
export (bool) var started: bool = false
export (bool) var stopped: bool = false

var ms: int
var s: int
var m: int
var total_time: String



# Set up
func _ready():
	talisman_anims.play("Default")
	anims.play("Default")



# When body is in circle
func _on_Offering_zone_body_entered(body: Node):
	if body.is_in_group("Body") and body.has_method("sacrifice"):
		body.sacrifice()
		talisman_anims.play("Revieve_offer")
		anim_loop = false

		GlobalSignals.emit_signal("shake", 0.05, 5)
		GlobalSignals.emit_signal("hit", 0.05)

		if !stopped:
			sacriffice_counter.text = str(needed_sacrifices - sacrifices - 1)

		sacrifices += 1
		if sacrifices >= needed_sacrifices:
			ending_timer.start()
			GlobalSignals.emit_signal("end")

			sacriffice_counter.text = total_time
			stopped = true

			anims.play("End")
			talisman_anims.play("Alive")

			if m > GlobalVariables.best_time:
				GlobalVariables.best_time = m

			if is_instance_valid(player):
				player.invincible = true
				player.can_move = false
				player.anim_playback.start("Idle")

		if sacrifices >= 1 and !started:
			GlobalSignals.emit_signal("start")
			game_timer.start()
			started = true
			anims.play("First")



# Process
func _process(delta):
	if !stopped:
		run_gametimer()

	if sacrifices >= 1 and anim_loop:
		talisman_anims.play("Float")

	if !ambience.is_playing():
		ambience.play()



# Run speedrun timer
func run_gametimer():
	if ms > 9:
		s += 1
		ms = 0

	if s > 59:
		m += 1
		s = 0

	total_time = (str(m) + ":" + str(s) + ":" + str(ms))


func _on_Game_timer_timeout():
	ms += 1



# End game
func _on_Ending_timer_timeout():
	get_tree().reload_current_scene() # Replace with back to menu




# Initialization
func initialize(player_obj):
	self.player = player_obj







