extends RigidBody2D

var kind = "TeleControl"

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.get_name() == "Paddle":
			var world_node = get_node("/root/World")
			if kind == "TeleControl":
				world_node.power_up_time_left_dict[kind] = 10
			queue_free()
