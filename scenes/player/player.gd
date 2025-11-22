extends CharacterBody2D


func _physics_process(_delta: float) -> void:
	if global_position.y >= 2000.0:
		LevelManager.restart_level()
		process_mode = Node.PROCESS_MODE_DISABLED
