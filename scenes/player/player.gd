class_name Player
extends CharacterBody2D


const PLAYER_DIED_PARTICLE = preload("uid://cvvfhp1r6w1gb")

@export_flags_2d_physics var spike_layer

@onready var platformer_movement_2d: PlatformerMovement2D = $PlatformerMovement2D
@onready var spike_check: SpikeCheck = $SpikeCheck


func _ready() -> void:
	spike_check.hit_a_spike.connect(
		func(): 
			call_deferred("_kill_player")
			)


func _physics_process(_delta: float) -> void:
	if global_position.y >= 2000.0:
		call_deferred("_kill_player")
		process_mode = Node.PROCESS_MODE_DISABLED


func _kill_player():
	var particle := PLAYER_DIED_PARTICLE.instantiate() as CPUParticles2D
	particle.global_position = global_position
	get_tree().current_scene.add_child(particle)
	queue_free()
	Global.player_died.emit()


func stop_player():
	platformer_movement_2d.process_mode = Node.PROCESS_MODE_DISABLED
