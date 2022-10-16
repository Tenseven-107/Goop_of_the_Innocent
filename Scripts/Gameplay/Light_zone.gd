extends Area2D



func _on_Damage_zone_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.in_light = true


func _on_Damage_zone_body_exited(body: Node):
	if body.is_in_group("Player"):
		body.in_light = false
