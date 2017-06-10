extends RigidBody2D

export var points_on_hit     = 250
export var points_for_winner = 500
export var speedup           = 5
export var max_speed         = 2000
export var min_abs_tangent   = 0.2

var telecontrol_speedup_x          = 25
var telecontrol_acceleration_x     = 40 setget increase_telecontrol_acceleration
var min_telecontrol_acceleration_x = 40
var max_telecontrol_acceleration_x = 120

const game_over_scene = preload("res://scenes/game_over.xml")
const winner_scene = preload("res://scenes/winner.xml")

func _ready():
	set_fixed_process(true)

func increase_telecontrol_acceleration():
	telecontrol_acceleration_x = min(telecontrol_acceleration_x + telecontrol_speedup_x, max_telecontrol_acceleration_x)

func trigger_game_over():
	var world_node = get_node("/root/World")
	world_node.update_high_score()
	var game_over_node = game_over_scene.instance()
	get_node("..").add_child(game_over_node)	

func free_ball():
	var world_node = get_node("/root/World")
	world_node.ball_counter = world_node.ball_counter - 1
	queue_free()
	
	if (world_node.ball_counter == 0):
		trigger_game_over()

func _fixed_process(delta):
	if get_pos().y > get_viewport_rect().end.y:
		free_ball()
	
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.is_in_group("Bricks"):
			get_node("/root/World").score += points_on_hit
			body.hit_brick()
			
			if get_tree().get_nodes_in_group("Bricks").size() == 1:
				get_node("/root/World").score += points_for_winner
				get_node("/root/World").update_high_score()
				queue_free()
				
				var winner_node = winner_scene.instance()
				get_node("..").add_child(winner_node)

		elif body.get_name() == "Paddle":
			var speed     = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Kickback").get_global_pos()
			var tangent_val = direction.y / direction.x
			var abs_tangent = abs(tangent_val)
			if (abs_tangent < min_abs_tangent):
				var tangent_sign = tangent_val / abs_tangent
				var new_tangent = min_abs_tangent * tangent_sign
				direction.y = direction.x * new_tangent
			var velocity  = direction.normalized() * min(speed + speedup, max_speed)
			set_linear_velocity(velocity)

	if get_node("/root/World").get_active_powerups().has("TeleControl"):
		var old_velocity = get_linear_velocity()
		var velocity_x = old_velocity.x
		var velocity_y = old_velocity.y
		
		var ball_pos_x = get_pos().x
		var paddle_pos_x = get_node("/root/World/Paddle").get_pos().x
		
		var screen_size_x = get_viewport().get_rect().size.x
		var acceleration_multiplier = (paddle_pos_x - ball_pos_x) / screen_size_x
		
		var acceleration = telecontrol_acceleration_x * acceleration_multiplier
		var velocity = Vector2(velocity_x + acceleration, velocity_y)
		set_linear_velocity(velocity)
	else:
		telecontrol_acceleration_x = min_telecontrol_acceleration_x