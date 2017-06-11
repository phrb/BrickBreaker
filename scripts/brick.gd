extends StaticBody2D

const powerup_scenes = {
	"TeleControl": preload("res://scenes/tele_control_powerup.xml"),
	"ExpandTab": preload("res://scenes/expand_pad_powerup.xml"),
	"MultiBall": preload("res://scenes/multiball_powerup.xml")
}

var powerup_spawning_probability = 0.20

var probabilities = [0.10, 0.20] setget set_prob
var life_values = [0, 1, 2]

var life
var texture

var has_powerup = false

var textures = [[preload("res://textures/brick1_1.png"),
				preload("res://textures/brick2_1.png"),
				preload("res://textures/brick3_1.png"),
				preload("res://textures/brick4_1.png")],
				[preload("res://textures/brick1_2.png"),
				preload("res://textures/brick2_2.png"),
				preload("res://textures/brick3_2.png"),
				preload("res://textures/brick4_2.png")],
				[preload("res://textures/brick1_3.png"),
				preload("res://textures/brick2_3.png"),
				preload("res://textures/brick3_3.png"),
				preload("res://textures/brick4_3.png")]]

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
	
	texture = randi() % textures[life].size()
	get_node("Sprite").set_texture(textures[life][texture])

func hit_brick():
	life -= 1
	
	if life == -1:
		if has_powerup:
			spawn_powerup()
		queue_free()
	else:
		get_node("Sprite").set_texture(textures[life][texture])

func spawn_powerup():
	var random_powerup_index = powerup_scenes.size() * randf();
	var random_powerup_key = powerup_scenes.keys()[random_powerup_index]
	
	var power_up = powerup_scenes[random_powerup_key].instance()
	power_up.set_pos(get_pos())
	power_up.add_to_group("PowerUps")
	get_node("/root/World").add_child(power_up)

func set_prob(probs):
	probabilities = probs