extends KinematicBody2D


onready var cam_transform = $Cam_transform
onready var weapon = $Knife

onready var sprite = $AnimatedSprite
onready var cursor = $Mouse

onready var scarf = $Scarf
onready var scarf_pos = $Scarf_pos

onready var anim_tree = $AnimationTree

export (bool) var can_move: bool = true
var speed: int = 0
export (int) var max_speed: int = 5000
export (int) var run_multiplier: int = 2
var velocity: Vector2 = Vector2()

export (int) var cursor_damping: int = 30
export (int) var max_scarf_length: int = 10

var anim_playback: AnimationNodeStateMachinePlayback



# Set up
func _ready():
	can_move = false
	weapon.initialize(self)

	anim_tree.active = true
	anim_playback = anim_tree.get("parameters/playback")
	anim_playback.start("Wake_up")



# processes
func _physics_process(delta):
	movement(delta)
	move_anims()
	mouse(delta)
	generate_scarf()



# Movement
func movement(delta):
	if can_move:

		velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
		velocity.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) / float(2)

		velocity = velocity.normalized() * speed * delta
		velocity = move_and_slide(velocity)

		if Input.is_action_pressed("run"):
			speed *= run_multiplier
		else:
			speed = max_speed
		speed = int(clamp(speed, 0, max_speed * run_multiplier))



# Move anims
func move_anims():
	if velocity.x != 0 or velocity.y != 0:
		anim_playback.travel("Walk")

		if velocity.x < 0:
			sprite.flip_h = false
		elif velocity.x > 0:
			sprite.flip_h = true

		if Input.is_action_pressed("run"):
			anim_playback.travel("Run")
	else:
		anim_playback.travel("Idle")



# Mouse
func mouse(delta):
	var mpos = get_global_mouse_position()
	var origin = Vector2(global_position.x, global_position.y - 12)
	cursor.global_position = lerp(origin, mpos, delta * cursor_damping)



# Set camera
func set_cam(cam_path: NodePath):
	cam_transform.remote_path = cam_path



# Generate trail
func generate_scarf():
	scarf.global_position = Vector2(0, 0)
	scarf.global_rotation = 0

	scarf.add_point(scarf_pos.global_position)

	while scarf.get_point_count() > max_scarf_length:
		scarf.remove_point(0)



# Player death
func die():
	anim_playback.travel("Die")



