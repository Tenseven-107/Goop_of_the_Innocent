extends KinematicBody2D


export (PackedScene) var spell: PackedScene

onready var idle_timer = $Idle_timer
onready var roam_timer = $Roam_timer
onready var track_timer = $Track_timer
onready var eye_timer = $Eye_timer

onready var eye = $Character/Eye

onready var spell_fx = $Character/Light_spell_fx

onready var anims = $Anims

onready var vis = $VisibilityNotifier2D

onready var eye_sfx = $SFX/Eye_scan
onready var light_sfx = $SFX/Spawn_light
onready var growl_sfx = $SFX/Monster_growl

var player = null

var speed: int = 2000
var velocity: Vector2 = Vector2()

export (int) var aggression: int = 0
export (int) var needed_aggression: int = 30

var rand_rot: float
var rand_dir: int


enum {
	IDLE
	ROAM
	TRACK
}
var state = null



# Set up
func _ready():
	set_state(IDLE)

	vis.connect("screen_entered", self, "show")
	vis.connect("screen_exited", self, "hide")



# Process
func _physics_process(delta):
	match state:
		IDLE:
			if idle_timer.is_stopped():
				idle_timer.start()

				speed += aggression

				eye_sfx.playing = true

			if eye_timer.is_stopped():
				rand_rot = rand_range(-1, 360)
				eye_timer.start()

			eye.rotation = lerp_angle(eye.rotation, rand_rot, 0.05)

			velocity = Vector2(0, 0)

			anims.play("idle")

		ROAM:
			if roam_timer.is_stopped():
				roam_timer.start()
				aggression += 1

			rand_dir = int(rand_range(0, 5))
			match rand_dir:
				1:velocity.x -= 1
				2:velocity.x += 1
				3:velocity.y -= 1
				4:velocity.y += 1

			velocity = velocity.normalized() * speed * delta

			anims.play("walk")
			eye_sfx.playing = false

		TRACK:
			if track_timer.is_stopped():
				track_timer.start()

				var spell_inst = spell.instance()
				spell_inst.global_position = global_position
				get_parent().call_deferred("add_child", spell_inst)

				light_sfx.play()
				spell_fx.emitting = true
				growl_sfx.play()
				eye_sfx.playing = true

			if is_instance_valid(player):
				velocity = (player.global_position - global_position).normalized()
				velocity = velocity.normalized() * speed * delta

				anims.play("walk")

				eye.rotation = global_position.angle_to_point(player.global_position)

	velocity = move_and_slide(velocity)



# Setting the state
func set_state(new_state):
	if new_state != null:
		state = new_state

	elif new_state == null:
		state = IDLE


# Timers
func _on_Idle_timer_timeout():
	if aggression < needed_aggression:
		set_state(ROAM)
	else:
		set_state(TRACK)


func _on_Roam_timer_timeout():
	set_state(IDLE)


func _on_Track_timer_timeout():
	set_state(ROAM)



# Initialization
func initialize(player_obj):
	self.player = player_obj






