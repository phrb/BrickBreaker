extends StaticBody2D

const simple_brick_scene = preload("res://scenes/power_up.xml")
const powerup_spawning_probability = 0.1

func _ready():
	pass

func queue_free_with_powerup():
	if (randf() > 1 - powerup_spawning_probability):
		var power_up = simple_brick_scene.instance()
		power_up.set_pos(get_pos())
		power_up.add_to_group("PowerUps")
		get_node("/root/World").add_child(power_up)
	queue_free()