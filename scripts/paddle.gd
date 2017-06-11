extends KinematicBody2D

const ball_scene = preload("res://scenes/ball.xml")

var default_scale = Vector2(0.3, 0.3)
var max_scale     = Vector2(1.8, 0.3)

var ball_presence = false
var game_over = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func reset_scale():
	set_scale(default_scale)
	
func scale_x_by(factor):
	if (get_scale().x + (factor * default_scale.x) <= max_scale.x):
		var new_scale = Vector2(get_scale().x + (default_scale.x * factor), default_scale.y)
		set_scale(new_scale)

func _fixed_process(delta):
	if game_over: return
	var y = get_pos().y
	var mouse_x = get_viewport().get_mouse_pos().x
	
	set_pos(Vector2(mouse_x, y))
	
	if (!get_parent().get_active_powerups().has("ExpandPad")):
		reset_scale()

func expand_pad():
	if (get_parent().get_active_powerups().has("ExpandPad")):
		scale_x_by(1)

func spawn_balls(num_balls):
	if (num_balls <= 0):
		return

	ball_presence = true
	var world_node = get_parent()
	var directions = []
	var velocities = []
	
	if (world_node.ball_counter > 0):
		directions = [Vector2(32, 32),
		              Vector2(-32, 32),
		              Vector2(-64, 32),
		              Vector2(64, 32)]
		
		velocities = [Vector2(-200, -250),
		              Vector2(200, -250),
		              Vector2(-300, -200),
		              Vector2(300, -200)]
	else:
		directions = [Vector2(0, 32),
		              Vector2(32, 32),
		              Vector2(-32, 32)]
		
		velocities = [Vector2(0, -400),
		              Vector2(200, -200),
		              Vector2(-200, -200)]
	
	for i in range(num_balls):
		var ball = ball_scene.instance()
		ball.set_pos(get_pos() - directions[i])
		ball.set_linear_velocity(velocities[i])
		get_tree().get_root().add_child(ball)
		

	world_node.ball_counter += num_balls

func _input(event):
	if !ball_presence and (event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		spawn_balls(1)
		ball_presence = true