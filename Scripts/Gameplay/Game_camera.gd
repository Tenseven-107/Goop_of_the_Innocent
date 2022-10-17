extends Camera2D



onready var shake_tween = $Shake_tween
onready var timer = $Timer

onready var hitstop_tween = $Hitstop_tween


# Set up
func _ready():
	GlobalSignals.connect("shake", self, "cam_shake")
	GlobalSignals.connect("hit", self, "hit_stop")



# Camera shake
func cam_shake(length, power):
	var x = rand_range(-power, power)
	var y = rand_range(-power, power)
	var vec = Vector2(x, y)

	shake_tween.interpolate_property(self, "offset", offset, vec, length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	shake_tween.start()

	timer.wait_time = length
	timer.start()


func _on_Timer_timeout():
	shake_tween.interpolate_property(self, "offset", offset, Vector2(0, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	shake_tween.start()



# Hitstop
func hit_stop(length):
	hitstop_tween.interpolate_property(Engine, "time_scale", 0.1, 1, length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hitstop_tween.start()
