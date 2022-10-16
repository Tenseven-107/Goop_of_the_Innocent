extends YSort



func _on_Offering_zone_body_entered(body: Node):
	if body.is_in_group("Body"):
		#body.sacrifice()
		print("a")
