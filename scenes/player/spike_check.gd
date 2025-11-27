class_name SpikeCheck
extends Area2D


signal hit_a_spike


func _ready() -> void:
	body_entered.connect(
		func(_col):
			hit_a_spike.emit()
	)
