extends CanvasLayer



onready var vignette = $Vignette
onready var kunai_counter = $Kunai_counter
onready var anims = $Anims

var player = null


# Set up
func _ready():
	anims.play("Transition_in")



# Process
func _process(delta):
	var mat = vignette.material
	if is_instance_valid(player):
		var intensity = (float(player.hp) / 100)

		mat.set_shader_param("vignette_intensity", intensity)

		if player.dead:
			anims.play("Transition_out")

		var kunais = player.thrower.kunais
		if kunais <= 0:
			kunai_counter.hide()
		else:
			kunai_counter.show()
			kunai_counter.text = str(kunais)



# Initialization
func initialize(player_obj):
	self.player = player_obj
