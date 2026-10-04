extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# Checks if the body touching the firefly has the custom light recharge code
	if body.has_method("charge_light"):
		body.charge_light(0.5) # Restores a solid chunk of light scale
		queue_free()          # Deletes the firefly from the game world
