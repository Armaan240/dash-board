extends Node2D

var speed := 0.5
var steer := 0.0

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		speed = move_toward(speed, 1.0, delta * 0.3)
	else:
		speed = move_toward(speed, 0.4, delta * 0.2)
