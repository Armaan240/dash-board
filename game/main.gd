extends Node2D

var speed := 0.5
var steer := 0.0

var car_scenes = [preload("res://game/traffic.tscn"),]
var road_base := 0.0
var sky_base := 0.0

func _ready():
	road_base = $road.position.x
	sky_base = $sky.position.x
	
var lanes = [-400.0, 400.0]
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		speed = move_toward(speed, 1.0, delta * 0.3)
	else:
		speed = move_toward(speed, 0.4, delta * 0.2)
	$road.speed_scale = speed * 3.0
	$road.position.x = road_base - steer * 300.0
	$sky.position.x = sky_base - steer * 80.0
func _on_spawn_timer_timeout():
	var car = car_scenes.pick_random().instantiate()
	car.lane_offset = lanes.pick_random()
	$Traffic.add_child(car)
