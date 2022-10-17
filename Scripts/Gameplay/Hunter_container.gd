extends YSort


export (PackedScene) var hunter: PackedScene

export (Array, Vector2) var start_positions
export (int) var max_positions: int = 4


var player = null



func spawn_hunter():
	if is_instance_valid(player):
		var hunter_inst = hunter.instance()
		var rand_pos = rand_range(-1, max_positions)

		hunter_inst.global_position = start_positions[rand_pos]
		hunter_inst.initialize(player)
		call_deferred("add_child", hunter_inst)



func initialize(player_obj):
	self.player = player_obj
	spawn_hunter()
