extends KinematicBody2D

const ball_scene = preload("res://scenes/ball.xml")
const default_scale = Vector2(0.3, 0.3)
var ball_presence = false
var game_over = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func reset_scale():
	set_scale(default_scale)
	
func double_horizontal_scale():
	var new_scale = Vector2(default_scale.x * 2, default_scale.y)
	set_scale(new_scale)
	
func _fixed_process(delta):
	if game_over: return
	var y = get_pos().y
	var mouse_x = get_viewport().get_mouse_pos().x
	set_pos(Vector2(mouse_x, y))
	if (get_parent().power_up_time_left_dict.has("ExpandTab")):
		double_horizontal_scale()
	else:
		reset_scale()
	
func _input(event):
	if !ball_presence and (event.type == InputEvent.MOUSE_BUTTON and event.is_pressed()):
		var ball = ball_scene.instance()
		ball.set_pos(get_pos() - Vector2(0, 32))
		get_tree().get_root().add_child(ball)
		ball_presence = true