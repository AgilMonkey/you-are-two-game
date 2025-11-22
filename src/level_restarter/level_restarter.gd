class_name LevelRestarter
extends Node


var is_restarting := false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart_level") and not is_restarting:
		LevelManager.restart_level()
		is_restarting = true
