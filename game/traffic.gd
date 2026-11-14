extends Node2D

var depth := 0.0
var lane_offset := 0.0
var drift := -60.0
const HORIZON_Y := 340.0
const BOTTOM_Y := 500.0
const VANISH_X := 640.0

@onready var main = get_tree().current_scene
@onready var sprite = $Sprite

func _process(delta):
	depth += delta * 0.1
	var t = depth * depth
	scale = Vector2.ONE * lerp(0.1, 1.0, t)
	position.y = lerp(HORIZON_Y, BOTTOM_Y, t)
	position.x = VANISH_X + (lane_offset + drift * depth - main.steer * 400.0) * t
	if depth > 1.2:
		queue_free()
