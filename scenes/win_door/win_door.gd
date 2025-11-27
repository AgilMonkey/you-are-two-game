@icon("res://assets/IconGodotNode/node_2D/icon_door.png")
class_name WinDoor
extends Node2D


signal door_just_touched

var is_door_touched := false

@export var color_no_player: Color
@export var color_yes_player: Color

@onready var win_area: Area2D = $WinArea
@onready var door_sound: AudioStreamPlayer = $DoorSound
@onready var door_sprite: Sprite2D = $Sprites/DoorSprite
@onready var arrow_down_sprite: Sprite2D = $Sprites/ArrowDownSprite


func _ready() -> void:
	win_area.body_entered.connect(_body_entered)
	win_area.body_exited.connect(_body_exit)


func _body_entered(_body):
	door_sprite.self_modulate = color_no_player
	arrow_down_sprite.self_modulate = color_no_player
	var bodies := win_area.get_overlapping_bodies()
	for _b in bodies:
		if _b.is_in_group("player"):
			if not is_door_touched:
				door_sound.play()
			is_door_touched = true
			door_just_touched.emit()
			door_sprite.self_modulate = color_yes_player
			arrow_down_sprite.self_modulate = color_yes_player
			break


func _body_exit(_body):
	is_door_touched = false
	door_sprite.self_modulate = color_no_player
	arrow_down_sprite.self_modulate = color_no_player
	var bodies := win_area.get_overlapping_bodies()
	for _b in bodies:
		if _b.is_in_group("player"):
			is_door_touched = true
			door_sprite.self_modulate = color_yes_player
			arrow_down_sprite.self_modulate = color_yes_player
			break
