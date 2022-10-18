extends Node2D


export (PackedScene) var kunai: PackedScene

onready var pos = $Position2D

export (int) var kunais: int = 0
export (Vector2) var counter_pos: Vector2 = Vector2(-3, 15)
var active: bool = true

var parent = null


# Process
func _physics_process(delta):
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("throw") and kunais > 0 and active and is_instance_valid(parent):
		var kunai_inst = kunai.instance()
		kunai_inst.global_transform = pos.global_transform
		parent.call_deferred("add_child", kunai_inst)

		kunais -= 1

		GlobalSignals.emit_signal("shake", 0.01, 2)


func _process(delta):
	pass



# Initialize
func initialize(parent_obj):
	self.parent = parent_obj
