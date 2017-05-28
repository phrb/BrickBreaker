extends RigidBody2D

const speedup   = 400
const max_speed = 30000

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
		elif body.get_name() == "Paddle":
			var speed     = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("Kickback").get_global_pos()
			var velocity  = direction.normalized() * min(speed + speedup * delta, max_speed * delta)
			set_linear_velocity(velocity)
			
	if get_pos().y > get_viewport_rect().end.y:
		queue_free()