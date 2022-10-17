extends Node


onready var wind = $Wind
onready var crickets = $Crickets
onready var music = $Music


func _ready():
	wind.play()
	crickets.play()

	GlobalSignals.connect("start", music, "play")
	GlobalSignals.connect("end", self, "end")


func end():
	crickets.stop()
	music.stop()
