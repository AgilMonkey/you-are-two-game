class_name PlayerJumpSound
extends AudioStreamPlayer


func play_random_jump_pitch():
	pitch_scale = randf_range(0.8, 1.2)
	play()
