extends YSort


export (Array, PackedScene) var scene_items

export (int) var max_items: int = 7
export (int) var max_spawns: int = 200

export (int) var spawn_zone_x: int
export (int) var spawn_zone_y: int

export (int) var exlcluded_zone_x: int
export (int) var exlcluded_zone_y: int


# Set up
func _ready():
	randomize()
	generate()



# Generate scene
func generate():
	for spawn in max_spawns:
		var picked_item = rand_range(-1, max_items)
		var item = scene_items[picked_item].instance()

		var x = rand_range(-spawn_zone_x, spawn_zone_x)
		var y = rand_range(-spawn_zone_y, spawn_zone_y) 

		item.global_position = Vector2(x, y)

		add_child(item)

		if (item.global_position.x < exlcluded_zone_x 
		and item.global_position.x > -exlcluded_zone_x 
		and item.global_position.y < exlcluded_zone_y 
		and item.global_position.y > -exlcluded_zone_y): 
			item.queue_free()
