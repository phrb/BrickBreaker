extends RigidBody2D

var name     = "ExpandPad"
var duration = 6

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.get_name() == "Paddle":
			get_node("/root/World").update_active_powerups(name, duration)
			body.expand_pad()
			queue_free()