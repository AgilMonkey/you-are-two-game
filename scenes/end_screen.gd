extends Control


func _on_button_button_down() -> void:
	LevelManager.change_level(LevelManager.LEVEL_01)
