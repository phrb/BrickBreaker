extends RigidBody2D

export var points_on_hit   = 250

export var speedup   = 5
export var max_speed = 2000

const PUP_TELE_ACC = 1000

const game_over_scene = preload("res://scenes/game_over.xml")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.is_in_group("Bricks"):
			get_node("/root/World").score += points_on_hit
			body.collapse_and_maybe_drop_power_up()

		elif body.get_name() == "Paddle":
			var speed     = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Kickback").get_global_pos()
			var velocity  = direction.normalized() * min(speed + speedup, max_speed)
			set_linear_velocity(velocity)

	if get_node("/root/World").power_up_time_left_dict.has("TeleControl"):
		var velocity_vec = get_linear_velocity()
		var velocity_x = velocity_vec.x
		var velocity_y = velocity_vec.y
		
		# Calculating the acceleration multiplier
		var ball_x_pos = get_pos().x
		var paddle_x_pos = get_node("/root/World/Paddle").get_pos().x
		var screen_x_size = get_viewport().get_rect().size.x
		var acc_multiplier = (paddle_x_pos - ball_x_pos) / screen_x_size
		
		# Calculating the acceleration
		var acceleration = PUP_TELE_ACC * acc_multiplier
		var velocity = Vector2(velocity_x + acceleration * delta, velocity_y)
		set_linear_velocity(velocity)
									
	if get_pos().y > get_viewport_rect().end.y:
		get_node("/root/World").update_high_score()
		queue_free()
		var game_over_node = game_over_scene.instance()
		get_node("..").add_child(game_over_node)