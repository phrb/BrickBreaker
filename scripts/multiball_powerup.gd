extends RigidBody2D

var name     = "MultiBall"
var duration = -1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.get_name() == "Paddle":
			body.spawn_balls(2)
			queue_free()