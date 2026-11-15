extends Node2D

var speed := 0.5
var steer := 0.0

var car_scenes = [preload("res://game/traffic.tscn"),]
var road_base := 0.0
var sky_base := 0.0
var vibration_on := true

func _ready():
	road_base = $road.position.x
	sky_base = $sky.position.x
	
const LANE := 200.0
var player_x := 0.0
var lanes = [-LANE, LANE] 

func _process(delta):
	var target := 0.4
	var rate := 0.2
	if Input.is_action_pressed("ui_up"):
		target = 1.0
		rate = 0.3
	if speed < 0.0:
		rate = 0.8
	speed = move_toward(speed, target, rate * delta)
	
	$road.speed_scale = speed * 3.0
	player_x = steer * LANE
	$road.position.x = road_base - player_x
	$sky.position.x = sky_base - player_x * 0.25
func _on_spawn_timer_timeout():
	if $Traffic.get_child_count() >= 3:
		return
	var car = car_scenes.pick_random().instantiate()
	car.lane_offset = lanes.pick_random()
	$Traffic.add_child(car)
	$SpawnTimer.wait_time = randf_range(2.5, 5.0)
	
func crash(car):
	car.bounce()
	speed = -0.6
	jolt()
	$crash.pitch_scale = randf_range(0.9, 1.1)
	$crash.play()
	if vibration_on:
		for pad in Input.get_connected_joypads():
			Input.start_joy_vibration(pad, 0.6, 1.0, 1.0)

func jolt():
	var tw = create_tween()
	tw.tween_property($Cockpit, "position:y", 25.0, 0.05)
	tw.tween_property($Cockpit, "position:y", 0.0, 0.6)\
		.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)	
	
