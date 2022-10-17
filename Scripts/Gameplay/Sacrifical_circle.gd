extends YSort


onready var ambience = $SFX/Circle_ambience

onready var talisman_anims = $Talisman/Talisman_anims


var sacrifices: int = 0
export (int) var needed_sacrifices: int = 20



# Set up
func _ready():
	talisman_anims.play("Float")



# When body is in circle
func _on_Offering_zone_body_entered(body: Node):
	if body.is_in_group("Body") and body.has_method("sacrifice"):
		body.sacrifice()

		sacrifices += 1
		if sacrifices >= needed_sacrifices:
			pass



# Process
func _process(delta):
	if !ambience.is_playing():
		ambience.play()
