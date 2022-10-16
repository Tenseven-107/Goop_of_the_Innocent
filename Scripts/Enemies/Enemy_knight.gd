extends KinematicBody2D


export (PackedScene) var body: PackedScene

onready var eye_timer = $Eye_timer
onready var roam_timer = $Roam_timer
onready var wait_timer = $Wait_timer

onready var eye = $Character/Eye

onready var anims = $Anims

onready var vis = $VisibilityNotifier2D

onready var eye_sfx = $SFX/Eye_scan

var body_container = null

var speed: int = 3000
var velocity: Vector2 = Vector2()


var rand_rot: float
var rand_dir: int


enum {
	IDLE
	ROAM
}
var state = null



# Set up
func _ready():
	anims.play("wake_up")
	set_state(IDLE)

	vis.connect("screen_entered", self, "show")
	vis.connect("screen_exited", self, "hide")



# Process
func _physics_process(delta):
	match state:
		IDLE:
			if wait_timer.is_stopped():
				wait_timer.start()

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

				eye_sfx.playing = false

			rand_dir = int(rand_range(0, 5))
			match rand_dir:
				1:velocity.x += 1
				2:velocity.x -= 1
				3:velocity.y += 1
				4:velocity.y -= 1

			velocity = velocity.normalized() * speed * delta

			anims.play("walk")

	velocity = move_and_slide(velocity)



# Setting the state
func set_state(new_state):
	if new_state != null:
		state = new_state

	elif new_state == null:
		state = IDLE



# Timers
func _on_Wait_timer_timeout():
	set_state(ROAM)


func _on_Roam_timer_timeout():
	set_state(IDLE)



# Handle damage
func die():
	if is_instance_valid(body_container):
		var body_inst = body.instance()
		body_inst.global_position = global_position
		body_container.call_deferred("add_child", body_inst)

		GlobalSignals.emit_signal("enemy_died")
		queue_free()



# Initialization
func initialize(body_cont):
	self.body_container = body_cont





