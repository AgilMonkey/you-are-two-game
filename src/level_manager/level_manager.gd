extends Node


const LEVEL_01 = preload("uid://dnxgbp16nxprc")
const LEVEL_02 = preload("uid://b5farnm1xi0y5")
const LEVEL_03 = preload("uid://dwvx81bgtpqyd")
const LEVEL_04 = preload("uid://ciu008em1c34")
const LEVEL_05 = preload("uid://b6s1olui86rrr")
const LEVEL_06 = preload("uid://dgv5fjoe780ha")
const END_SCREEN = preload("uid://5mhg5obx2g4t")

var all_levels := [
	LEVEL_01,
	LEVEL_02,
	LEVEL_03,
	LEVEL_04,
	LEVEL_05,
	LEVEL_06,
	END_SCREEN,
]
var cur_level = 0

@onready var scene_transitioner: SceneTransitioner = $UI/SceneTransitioner
@onready var reset_sound: AudioStreamPlayer = $ResetSound


func change_level(_scene: PackedScene):
	scene_transitioner.start_trans()
	await scene_transitioner.in_trans_middle
	get_tree().change_scene_to_packed(_scene)


func change_to_level_num(_num: int):
	var _scene = all_levels[_num]
	change_level(_scene)


func restart_level():
	reset_sound.play()
	scene_transitioner.start_trans()
	await scene_transitioner.in_trans_middle
	get_tree().reload_current_scene()
