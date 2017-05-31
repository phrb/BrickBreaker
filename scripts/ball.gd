extends RigidBody2D

# TODO: Get rid of magic numbers
export var points_on_hit   = 250
export var points_on_death = -750

export var speedup   = 60
export var max_speed = 1500

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.is_in_group("Bricks"):
			get_node("/root/World").score += points_on_hit
			body.queue_free()
		elif body.get_name() == "Paddle":
			var speed     = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Kickback").get_global_pos()
			var velocity  = direction.normalized() * min(speed + speedup, max_speed)
			set_linear_velocity(velocity)
			
	if get_pos().y > get_viewport_rect().end.y:
		get_node("/root/World").score += points_on_death
		queue_free()
		get_tree().reload_current_scene()