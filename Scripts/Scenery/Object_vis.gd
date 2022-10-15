extends Node2D


onready var vis = $VisibilityNotifier2D


func _ready():
	vis.connect("screen_entered", self, "show")
	vis.connect("screen_exited", self, "hide")
