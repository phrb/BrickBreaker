extends StaticBody2D

const tele_control = preload("res://scenes/tele_control_powerup.xml")
export var powerup_spawning_probability = 0.03

func _ready():
	pass

func queue_free_with_powerup():
	if (randf() <= powerup_spawning_probability):
		var power_up = tele_control.instance()
		
		power_up.set_pos(get_pos())
		power_up.add_to_group("PowerUps")
		get_node("/root/World").add_child(power_up)
		
	queue_free()