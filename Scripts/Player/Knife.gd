extends Node2D


onready var collider = $Area2D/CollisionShape2D
onready var timer = $Attack_timer
onready var anims = $AnimationPlayer

var player = null



# Set up
func _ready():
	collider.disabled = true



# Process
func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("attack") and timer.is_stopped():
		anims.play("Attack")
		timer.start()

		if is_instance_valid(player):
			player.can_move = false



# Handle damage
func _on_Area2D_body_entered(body: Node):
	if body.is_in_group("Enemies"):
		body.die()



# activate player movement
func _on_Attack_timer_timeout():
	if is_instance_valid(player):
		player.can_move = true



# Initialization
func initialize(player_obj):
	self.player = player_obj



