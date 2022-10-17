extends YSort


onready var container = $Enemy_container
onready var body_container = $Body_container

export (Array, PackedScene) var enemies

export (int) var max_enemies: int = 3
export (int) var max_spawns: int = 500

export (int) var spawn_zone_x: int
export (int) var spawn_zone_y: int

export (int) var exlcluded_zone_x: int
export (int) var exlcluded_zone_y: int

# Set up
func _ready():
	randomize()
	GlobalSignals.connect("enemy_died", self, "check_container")

	# Start spawning enemies when entering scene
	for spawn in max_spawns:
		spawn()


# Spawn enemies
func spawn():
	var picked_enemy = rand_range(-1, max_enemies)
	var enemy = enemies[picked_enemy].instance()

	var x = rand_range(-spawn_zone_x, spawn_zone_x)
	var y = rand_range(-spawn_zone_y, spawn_zone_y)

	var pos = Vector2(x, y)

	if (pos.x < exlcluded_zone_x 
	and pos.x > -exlcluded_zone_x 
	and pos.y < exlcluded_zone_y 
	and pos.y > -exlcluded_zone_y): 
		pass
	else:
		enemy.global_position = pos
		enemy.initialize(body_container)
		container.call_deferred("add_child", enemy)



# Check container
func check_container():
	var count = container.get_child_count()

	if count < max_spawns:
		spawn()




