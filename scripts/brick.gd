extends StaticBody2D

const powerup_scenes = {
	"TeleControl": preload("res://scenes/tele_control_powerup.xml"),
	"ExpandTab": preload("res://scenes/expand_tab_powerup.xml")
}
export var powerup_spawning_probability = 0.03


func _ready():
	pass

func queue_free_with_powerup():
	if (randf() <= powerup_spawning_probability):
		var random_powerup_index = powerup_scenes.size() * randf();
		var random_powerup_key = powerup_scenes.keys()[random_powerup_index]
		
		if (not get_node("/root//World").power_up_time_left_dict.has(random_powerup_key)):
			var power_up = powerup_scenes[random_powerup_key].instance()
			power_up.set_pos(get_pos())
			power_up.add_to_group("PowerUps")
			get_node("/root/World").add_child(power_up)
		
	queue_free()