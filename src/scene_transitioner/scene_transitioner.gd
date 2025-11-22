class_name SceneTransitioner
extends Control


signal in_trans_middle
signal trans_ended

@export var shader: ShaderMaterial 

var cur_tween: Tween

@onready var texture_trans: TextureRect = $TextureTrans


func start_trans():
	if cur_tween != null: cur_tween.stop()
	cur_tween = create_tween()
	shader.set_shader_parameter("shader_parameter/fill_amount", 0.4)
	cur_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	cur_tween.tween_property(shader, "shader_parameter/fill_amount", 1.0, 0.8)
	cur_tween.tween_callback(func(): in_trans_middle.emit())
	cur_tween.tween_interval(0.5)
	cur_tween.tween_property(shader, "shader_parameter/fill_amount", 0.0, 1.2)
	cur_tween.tween_callback(func(): trans_ended.emit())
