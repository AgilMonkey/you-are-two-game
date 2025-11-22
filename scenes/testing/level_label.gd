extends PanelContainer


func _ready() -> void:
	LevelManager.scene_transitioner.trans_ended.connect(show_level_label)


func show_level_label():
	var _original_pos := position
	var _up_pos := position + Vector2.UP * size.y
	var tween := create_tween()
	tween.tween_property(self, "position", _up_pos, 0.4)
	tween.tween_interval(1.5)
	tween.tween_property(self, "position", _original_pos, 0.4)
