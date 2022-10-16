extends StaticBody2D


onready var interaction_box = $Interaction_box/CollisionShape2D

onready var text = $Interaction_box/Text
onready var tut_timer = $Tut_timer
onready var tut_tween = $Interaction_box/Text/Tween

onready var goop_particles = $CPUParticles2D
onready var goop_timer = $Goop_timer
onready var goop_trail = $Goop_trail
onready var goop_particles_trail = $CPUParticles2D2

var player = null

export (int) var trail_length: int = 10

var drag_mode: bool = false
var active: bool = false


# Set up
func _ready():
	goop_timer.start()
	goop_particles.emitting = true
	goop_particles_trail.emitting = false

	text.modulate = Color(1, 1, 1, 0)



# Process
func _physics_process(delta):
	if Input.is_action_just_pressed("drag") and active and !player.drag_mode:
		drag_mode = true
		interaction_box.disabled = true

		text.hide()
		goop_particles.hide()

		if is_instance_valid(player):
			player.drag_mode = true

	if drag_mode and is_instance_valid(player):
		global_position = player.global_position

		generate_trail()
		goop_particles_trail.emitting = true



# Sacrifice
func sacrifice():
	if is_instance_valid(player):
		player.drag_mode = false



# Make puddle
func _on_Goop_timer_timeout():
	goop_particles.set_process_internal(false)



# Body interaction
func _on_Interaction_box_body_entered(body: Node):
	if body.is_in_group("Player"):
		tut_timer.start()
		text.show()

		player = body
		active = true


func _on_Interaction_box_body_exited(body: Node):
	if body.is_in_group("Player"):
		tut_timer.stop()
		text.hide()



# Show text
func _on_Tut_timer_timeout():
	tut_tween.interpolate_property(text, "modulate:a", 0, 1, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tut_tween.start()



# Generate trail
func generate_trail():
	goop_trail.global_position = Vector2(0, 0)
	goop_trail.global_rotation = 0

	var pos = Vector2(global_position.x, global_position.y - 4)
	goop_trail.add_point(pos)

	while goop_trail.get_point_count() > trail_length:
		goop_trail.remove_point(0)




