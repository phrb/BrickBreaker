extends RigidBody2D

export var points_on_hit     = 250
export var points_for_winner = 500
export var speedup           = 5
export var max_speed         = 2000

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
	world_node.save()
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
			get_node("/root/World").set_score(get_node("/root/World").get_score() + points_on_hit)
			body.hit_brick()
			get_node("/root/World").set_combo(get_node("/root/World").get_combo() + 1)
			
			if get_node("/root/World").get_combo() % 5 == 0:
				get_node("/root/World/Background").scale_rotation_by(2)
			
			if get_tree().get_nodes_in_group("Bricks").size() == 1:
				get_node("/root/World").set_score(get_node("/root/World").get_score() + points_for_winner)
				get_node("/root/World").update_saved_labels()
				queue_free()
				
				var winner_node = winner_scene.instance()
				get_node("..").add_child(winner_node)

		elif body.get_name() == "Paddle":
			var speed     = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Kickback").get_global_pos()
			var velocity  = direction.normalized() * min(speed + speedup, max_speed)
			set_linear_velocity(velocity)
			
			get_node("/root/World").update_max_combo()
			get_node("/root/World").set_combo(0)
			get_node("/root/World/Background").reset_rotation()

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