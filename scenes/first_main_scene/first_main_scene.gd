extends Node2D


@onready var title: Label = $GUI/MainControl/VBoxContainer/Title
@onready var press_z_to_continue: Label = $"GUI/MainControl/VBoxContainer/Press z to continue"


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		LevelManager.change_level(LevelManager.LEVEL_01)


func _ready() -> void:
	title.visible_characters = 0
	press_z_to_continue.visible_characters = 0
	
	var _t = create_tween()
	_t.tween_interval(1.5)
	_t.tween_property(title, "visible_ratio", 1.0, 1.5)
	_t.tween_interval(.5)
	_t.tween_property(press_z_to_continue, "visible_ratio", 1.0, 2.5)
