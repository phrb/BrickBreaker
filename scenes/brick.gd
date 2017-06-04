extends StaticBody2D

const simple_brick_scene = preload("res://scenes/power_up.tscn")

func _ready():
	pass

func collapse_and_maybe_drop_power_up():
	# This give us 10% of chance of a new PowerUp to be dropped
	if (decision_var > 0.9):
		var power_up = simple_brick_scene.instance()
		power_up.set_pos(get_pos())
		power_up.add_to_group("PowerUps")
		get_node("/root/World").add_child(power_up)
		queue_free()
