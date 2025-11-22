extends Node


@onready var music_1: AudioStreamPlayer = $Music1


func _ready() -> void:
	_play_music()


func _play_music():
	music_1.volume_db = -80.0
	music_1.play()
	
	var _t = create_tween()
	_t.tween_property(music_1, "volume_db", -4.0, 0.6)
