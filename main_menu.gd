extends Control

const GAME_LEVEL_PATH = "res://main.tscn"

# 1. This triggers when you click the "Start" button node
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(GAME_LEVEL_PATH)

# 2. This triggers when you click the "Exit" button node
func _on_exit_pressed() -> void:
	get_tree().quit()
