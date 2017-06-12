extends RigidBody2D

var name     = ["ExpandPad", "ReducePad"]
var duration = 10

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()

	for body in colliding_bodies:
		if body.get_name() == "Paddle":
			var index = randi()%2
			get_node("/root/World").update_active_powerups(name[index], duration)
			if name[index] == "ExpandPad":
				body.expand_pad()
			else:
				body.reduce_pad()
			queue_free()