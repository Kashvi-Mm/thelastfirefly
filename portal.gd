extends Area2D

const VICTORY_SCENE_PATH = "res://victory_screen.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("charge_light"):
		get_tree().change_scene_to_file(VICTORY_SCENE_PATH)
