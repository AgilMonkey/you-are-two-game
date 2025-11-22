class_name PlatformerMovement2D
extends Node2D


signal jumped

@export var speed := 300.0

@export var jump_force := -700.0
@export var var_jump_pulldown_f := 3500.0

var _is_jumping := false

@onready var body: CharacterBody2D = get_parent()
@onready var gravity_y: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_ground_ray: RayCast2D = $"../PlayerGroundRay"
@onready var player_ground_shape_cast: ShapeCast2D = $"../PlayerGroundShapeCast"



func _physics_process(delta: float) -> void:
	# Horizontal movement
	var _inp_hor = Input.get_axis("move_left", "move_right")
	
	body.velocity.x = _inp_hor * speed
	
	# Jumping
	if Input.is_action_just_pressed("jump") and (body.is_on_floor() or player_ground_shape_cast.is_colliding()):
		_is_jumping = true
		body.velocity.y = jump_force
		jumped.emit()
	
	if _is_jumping and body.velocity.y > 0.0:
		_is_jumping = false
	
	var _is_jump_inp_pressed = Input.is_action_pressed("jump")
	var _should_var_jump = not _is_jump_inp_pressed and _is_jumping
	if _should_var_jump:
		# var jump gravity
		body.velocity.y += var_jump_pulldown_f * delta
	else:
		# Normal Gravity
		body.velocity.y += gravity_y * delta
	
	body.move_and_slide()
