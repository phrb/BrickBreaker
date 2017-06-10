extends StaticBody2D

const powerup_scenes = {
	"TeleControl": preload("res://scenes/tele_control_powerup.xml"),
	"ExpandTab": preload("res://scenes/expand_pad_powerup.xml"),
	"MultiBall": preload("res://scenes/multiball_powerup.xml")
}
var powerup_spawning_probability = 0.10

var probabilities = [0.10, 0.20] setget set_prob
var colors = [Color(30, 90, 20), Color(90, 30, 20), Color(30, 20, 90)]
var life_values = [0, 1, 2]
var life

var has_powerup = false

func _ready():
	randomize()
	
	if (randf() <= powerup_spawning_probability):
		get_node("PowerUp").show()
		has_powerup = true

	var p = randf()
	var life_value = 0
	
	if (p < probabilities[0]):
		life_value = 2
	elif (p < probabilities[1]):
		life_value = 1
		
	life = life_values[life_value]
	get_node("Sprite").set_modulate(colors[life_value])

func hit_brick():
	life -= 1
	if life == -1:
		if has_powerup:
			spawn_powerup()
		queue_free()
	else:
		get_node("Sprite").set_modulate(colors[life])

func spawn_powerup():
	var random_powerup_index = powerup_scenes.size() * randf();
	var random_powerup_key = powerup_scenes.keys()[random_powerup_index]
	
	var power_up = powerup_scenes[random_powerup_key].instance()
	power_up.set_pos(get_pos())
	power_up.add_to_group("PowerUps")
	get_node("/root/World").add_child(power_up)

func set_prob(probs):
	probabilities = probs