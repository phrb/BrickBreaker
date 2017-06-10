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
	for i in range(num_balls):
		var ball = ball_scene.instance()
		ball.set_pos(get_pos() - Vector2(0, 32))
		get_tree().get_root().add_child(ball)
		
	var world_node = get_parent()
	var old_ball_count = world_node.ball_counter
	world_node.ball_counter = old_ball_count + num_balls
	
	if (num_balls > 0):
		ball_presence = true

func _input(event):
	if !ball_presence and (event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		spawn_balls(1)
		ball_presence = true