extends Node2D

var depth := 0.0
var lane_offset := 0.0
var drift := -60.0
var hit := false
var knocked := false

const HORIZON_Y := 205.0
const BOTTOM_Y := 450.0
const VANISH_X := 640.0

@onready var main = get_tree().current_scene
@onready var sprite = $Sprite


func _process(delta):
	if not knocked:
		depth += delta * main.speed * 0.25
	sprite.speed_scale = main.speed * 3.0
	var t = depth * depth
	var tx = pow(depth, 2.5)
	scale = Vector2.ONE * lerp(0.05, 0.8, t)
	position.y = lerp(HORIZON_Y, BOTTOM_Y, t)
	position.x = VANISH_X + lane_offset * tx - main.steer * 300.0
	if not hit and depth > 0.9 and abs(position.x - VANISH_X) < 150.0:
		main.crash(self)
		queue_free()
		
func bounce():
	hit = true
	knocked = true
	var tw = create_tween()
	tw.tween_property(self, "depth", depth - 0.4, 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func(): knocked = false)
