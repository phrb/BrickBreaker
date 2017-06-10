extends Node2D

var score = 0 setget set_score
var high_score = 0
var high_score_path = "user://high_score.save"
var data = {"high_score": 0}
var save_game = File.new()
var ball_counter = 0

var active_powerups = {} setget update_active_powerups, get_active_powerups

func update_active_powerups(powerup, time):
	if (active_powerups.has(powerup)):
		active_powerups[powerup] += time / 2
	else:
		active_powerups[powerup] = time

func get_active_powerups():
	return active_powerups

func _ready():
	load_high_score()
	update_high_score_label()
	set_process(true)
	
func _process(delta):
	for power_up in active_powerups.keys():
		var time_left = active_powerups[power_up] - delta
		if (time_left < 0):
			active_powerups.erase(power_up)
		else:
			active_powerups[power_up] = time_left

func update_high_score_label():
	get_node("HighScore").set_text("High Score: " + str(high_score))

func update_high_score():
	if score > high_score:
		data["high_score"] = score
		save_game.open(high_score_path, File.WRITE)
		save_game.store_var(data)
		save_game.close()

func load_high_score():
	if !save_game.file_exists(high_score_path): return

	save_game.open(high_score_path, File.READ)
	data = save_game.get_var()
	save_game.close()
	high_score = data["high_score"]

func set_score(value):
	score = value
	get_node("Score").set_text("Score: " + str(score))