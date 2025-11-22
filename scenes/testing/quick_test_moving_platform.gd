extends Path2D


@onready var path_follow_2d: PathFollow2D = $PathFollow2D


func _ready() -> void:
	var _t = create_tween()
	_t.set_loops()
	#_t.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_t.tween_property(path_follow_2d, "progress_ratio", 1.0, 1.0)
	_t.tween_property(path_follow_2d, "progress_ratio", 0.0, 1.0)
