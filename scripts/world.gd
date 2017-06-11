extends Node2D

var max_combo = 0
var combo_length = 0 setget set_combo, get_combo

var score = 0 setget set_score, get_score
var high_score = 0

var save_path = "user://brickbreaker.save"
var data = {"high_score": 0, "max_combo": 0}

var save_game = File.new()
var ball_counter = 0

var active_powerups = {} setget update_active_powerups, get_active_powerups

func update_max_combo():
	if combo_length > max_combo:
		max_combo = combo_length
		get_node("MaxCombo").set_text("Max Combo: " + str(max_combo))

func set_combo(combo):
	combo_length = combo
	get_node("Combo").set_text("Combo: " + str(combo_length))

func get_combo():
	return combo_length

func update_active_powerups(powerup, time):
	if (active_powerups.has(powerup)):
		active_powerups[powerup] += time / 2
	else:
		active_powerups[powerup] = time

func get_active_powerups():
	return active_powerups

func remove_balls():
	for ball_node in get_tree().get_nodes_in_group("Balls"):
		ball_node.free()

func _ready():
	load_save()
	update_saved_labels()
	set_process(true)
	
func _process(delta):
	for power_up in active_powerups.keys():
		var time_left = active_powerups[power_up] - delta
		if (time_left < 0):
			active_powerups.erase(power_up)
		else:
			active_powerups[power_up] = time_left

func update_saved_labels():
	get_node("HighScore").set_text("High Score: " + str(high_score))
	get_node("MaxCombo").set_text("Max Combo: " + str(max_combo))

func save():
	if score > high_score:
		data["high_score"] = score

	if combo_length > max_combo:
		data["max_combo"] = combo_length
		
	save_game.open(save_path, File.WRITE)
	save_game.store_var(data)
	save_game.close()
	

func load_save():
	if !save_game.file_exists(save_path): return

	save_game.open(save_path, File.READ)
	data = save_game.get_var()
	save_game.close()
	high_score = data["high_score"]
	max_combo = data["max_combo"]

func get_score():
	return score

func set_score(value):
	score = value
	get_node("Score").set_text("Score: " + str(score))