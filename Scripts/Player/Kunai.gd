extends Area2D


onready var timer = $Timer
onready var trail = $Trail
onready var puff = $Puff
onready var tween = $Tween
onready var sfx = $SFX

export (int) var speed: int = 500
export (int) var trail_length: int = 10


func _ready():
	timer.start()
	puff.emitting = true
	sfx.play()



func _physics_process(delta):
	position += transform.x * speed * delta

	trail.global_position = Vector2(0, 0)
	trail.global_rotation = 0

	trail.add_point(global_position)

	while trail.get_point_count() > trail_length:
		trail.remove_point(0)



func _on_Timer_timeout():
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(0, 0), 0.1, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object, key):
	if object == self:
		queue_free()



func _on_Kunai_body_entered(body: Node):
	if body.is_in_group("Enemies") and body.has_method("die"):
		body.die()
		call_deferred("queue_free")
	elif body.is_in_group("Enemies")and body.has_method("handle_hit"):
		body.handle_hit()
		call_deferred("queue_free")




