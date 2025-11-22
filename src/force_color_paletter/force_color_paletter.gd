@tool
@icon("res://assets/IconGodotNode/node/icon_color_correction.png")
class_name ForceColorPaletter
extends Node


var default_color_pallete: ColorPalette

@export var cur_color := -1:
	set(_val):
		var clamp_val = clampi(_val, -1, max_color-1)
		cur_color = clamp_val

var max_color := 0


func _process(_delta: float) -> void:
	default_color_pallete = load("uid://bw0012ng6p2w7")
	max_color = default_color_pallete.colors.size()
	if cur_color == -1: return
	
	var _par: CanvasItem = get_parent()
	_par.self_modulate = default_color_pallete.colors[cur_color]
