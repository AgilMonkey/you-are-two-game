class_name LevelWinLogic
extends Node


@export var next_level_num := 0

var all_doors: Array[WinDoor]


func _ready() -> void:
	all_doors = _type_array()
	assert(all_doors.size() > 0, "Yo wtf. There's no door")
	
	for _d in all_doors:
		_d.door_just_touched.connect(
			func():
				if _check_if_all_door_is_touched():
					_win_level()
		)


func _win_level():
	call_deferred("_stop_all_player")
	LevelManager.change_to_level_num(next_level_num)


func _stop_all_player():
	var p : Array[Player] = []
	p.append_array(get_tree().get_nodes_in_group("player"))
	
	for _p_n in p:
		_p_n.stop_player()


func _check_if_all_door_is_touched() -> bool:
	var _all_door_is_touched := true
	for _dd in all_doors:
		if not _dd.is_door_touched:
			_all_door_is_touched = false
			break
	
	return _all_door_is_touched


func _type_array():
	var typed_array : Array[WinDoor] = []
	typed_array.append_array(get_tree().get_nodes_in_group("win_door"))
	return typed_array
