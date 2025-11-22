extends ShapeCast2D


@export_flags_2d_physics var og_mask
@export_flags_2d_physics var col_mask

var last_p_col: CharacterBody2D
@onready var player: CharacterBody2D = $".."

func _physics_process(_delta: float) -> void:
	if player.is_on_ceiling() and last_p_col != null:
		last_p_col.collision_mask = og_mask
		last_p_col = null
		return
	
	if is_colliding():
		var n: CharacterBody2D = get_collider(0)
		if n.is_in_group("player"):
			n.collision_mask = col_mask
		last_p_col = n
	elif last_p_col != null:
		last_p_col.collision_mask = og_mask
		last_p_col = null
