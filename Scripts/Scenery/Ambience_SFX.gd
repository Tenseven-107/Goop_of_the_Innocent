extends Node


onready var wind = $Wind
onready var crickets = $Crickets
onready var music = $Music


func _ready():
	wind.play()
	crickets.play()
	music.play()
