extends RayCast2D


@export_flags_2d_physics var og_layer
@export_flags_2d_physics var col_layer

var last_p_col: CharacterBody2D
@onready var player: CharacterBody2D = $".."

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var n: CharacterBody2D = get_collider()
		if n.is_in_group("player"):
			n.collision_mask = col_layer
		last_p_col = n
	elif last_p_col != null:
		last_p_col.collision_mask = og_layer
		last_p_col = null
