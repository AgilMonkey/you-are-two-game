class_name LevelButton
extends Button


@export var level_change_to := 0


func _ready() -> void:
	pressed.connect(
		func():
			LevelManager.change_level(LevelManager.all_levels[level_change_to])
	)
