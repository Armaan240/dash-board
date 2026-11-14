extends Sprite2D

var steer := 0.0
const SENSITIVITY := 0.003

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
func _input(event):
	if event is InputEventMouseMotion:
		steer = clamp(steer + event.relative.x * SENSITIVITY, -0.5, 0.5)

func _process(delta):
	steer = move_toward(steer, 0.0, delta * 0.3)
	rotation = lerp_angle(rotation, steer * deg_to_rad(120), delta * 10)
	
