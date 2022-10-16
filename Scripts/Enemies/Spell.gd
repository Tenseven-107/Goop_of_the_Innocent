extends Node2D


onready var anims = $AnimationPlayer
onready var vis = $VisibilityNotifier2D


func _ready():
	anims.play("Spell_effect")

	vis.connect("screen_entered", self, "show")
	vis.connect("screen_exited", self, "hide")
