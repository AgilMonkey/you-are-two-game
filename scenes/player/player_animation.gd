extends Node2D


const MAX_STRENGTH := 200.0
const MAX_Y_SCALE_ADD := 0.05
const SCALE_LERP_TIME := 0.08
const LERP_TIME := 0.05

var is_ping_pong_scale := false
var cur_strength := 0.0
var cur_pivot_y_scale := 1.0

var tween_jumping: Tween
var tween_ground_hit: Tween

@onready var player: CharacterBody2D = $".."
@onready var sprite_pivot: Node2D = $"../SpritePivot"
@onready var sprite_2d: Sprite2D = $"../SpritePivot/Sprite2D"
@onready var platformer_movement_2d: PlatformerMovement2D = $"../PlatformerMovement2D"


func _ready() -> void:
	tween_jumping = create_tween()
	tween_ground_hit = create_tween()
	tween_jumping.stop()
	tween_ground_hit.stop()
	
	platformer_movement_2d.jumped.connect(
		func():
			if tween_ground_hit != null: tween_ground_hit.stop()
			tween_jumping = create_tween()
			tween_jumping.tween_property(sprite_pivot, "scale", Vector2(0.8, 1.3), 0.1)
			tween_jumping.tween_property(sprite_pivot, "scale", Vector2(1.0, 1.0), 0.1)
			#tween_jumping.tween_callback(tween_jumping.kill)
	)
	
	platformer_movement_2d.just_hit_floor_after_falling.connect(
		func():
			if tween_ground_hit != null: tween_ground_hit.stop()
			tween_ground_hit = create_tween()
			tween_ground_hit.tween_property(sprite_pivot, "scale", Vector2(1.2, 0.9), 0.1)
			tween_ground_hit.tween_property(sprite_pivot, "scale", Vector2(1.0, 1.0), 0.1)
			#tween_ground_hit.tween_callback(tween_ground_hit.kill)
	)


func _physics_process(delta: float) -> void:
	pass
	#if not _is_player_stop_moving():
		#if player.get_real_velocity().x > 0.0:
			#cur_strength = lerpf(cur_strength, MAX_STRENGTH, delta / LERP_TIME)
		#else:
			#cur_strength = lerpf(cur_strength, -MAX_STRENGTH, delta / LERP_TIME)
		#
		#if player.is_on_floor():
			#_ping_pong_scale(delta)
			#sprite_pivot.scale.y = cur_pivot_y_scale
	#elif player.is_on_floor():
		#_return_y_scale_to_zero(delta)
	
	#if not player.is_on_floor():
		#if platformer_movement_2d.is_falling:
			#var _s = sprite_pivot.scale
			#sprite_pivot.scale.x = lerp(sprite_pivot.scale.x, 0.7, delta)
			#sprite_pivot.scale.y = lerp(sprite_pivot.scale.y, 1.4, delta)
			#sprite_pivot.scale = Vector2(max(0.7, sprite_pivot.scale.x), min(1.4, sprite_pivot.scale.y))
		#elif tween_ground_hit == null and tween_jumping == null:
			#cur_pivot_y_scale = lerpf(cur_pivot_y_scale, 1.0, delta / SCALE_LERP_TIME)
	#
	#cur_strength = lerpf(cur_strength, 0.0, delta / LERP_TIME)
	#
	#_set_shader_skew_strength(cur_strength)


func _is_player_stop_moving():
	return player.get_real_velocity().x == 0.0 or Input.get_axis("move_left", "move_right") == 0.0


func _ping_pong_scale(delta):
	if platformer_movement_2d.is_on_top_of_another_player: return
	
	var _target_y_scale = 1.0 + MAX_Y_SCALE_ADD
	if is_ping_pong_scale:
		_target_y_scale = 1.0 - MAX_Y_SCALE_ADD
	
	cur_pivot_y_scale = lerpf(cur_pivot_y_scale, _target_y_scale, delta / SCALE_LERP_TIME)
	
	if not is_ping_pong_scale and cur_pivot_y_scale >= _target_y_scale - 0.01:
		is_ping_pong_scale = true
	elif cur_pivot_y_scale <= _target_y_scale + 0.01:
		is_ping_pong_scale = false


func _return_y_scale_to_zero(_delta):
	if tween_ground_hit.is_running() or tween_jumping.is_running(): return
	cur_pivot_y_scale = lerpf(cur_pivot_y_scale, 1.0, _delta / SCALE_LERP_TIME)
	sprite_pivot.scale.y = cur_pivot_y_scale


func _set_shader_skew_strength(_val: float):
	sprite_2d.material.set_shader_parameter("strength", _val)
