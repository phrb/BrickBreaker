extends KinematicBody2D

const ball_scence = preload("res://scenes/ball.xml")

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	var y = get_pos().y
	var mouse_x = get_viewport().get_mouse_pos().x
	set_pos(Vector2(mouse_x, y))
	
func _input(event):
	# TODO: Change event type for android touch
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		var ball = ball_scence.instance()
		ball.set_pos(get_pos() - Vector2(0, 32))
		get_tree().get_root().add_child(ball)