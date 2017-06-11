extends RigidBody2D

var name     = "TeleControl"
var duration = 10

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var colliding_bodies = get_colliding_bodies()
	
	for body in colliding_bodies:
		if body.get_name() == "Paddle":
			get_node("/root/World").update_active_powerups(name, duration)
			if has_node("/root/World/Ball"):
				get_node("/root/World/Ball").increase_telecontrol_acceleration()
			queue_free()