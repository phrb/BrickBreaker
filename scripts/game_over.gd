extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("../World/Paddle").game_over = true
	var high_score = get_node("/root/World").high_score
	var your_score = get_node("/root/World").score
	if your_score < high_score:
		get_node("high_score_msg").hide()
	get_node("high_score").set_text(str(high_score))
	get_node("your_score").set_text(str(your_score))
	
	get_node("play").connect("pressed", self, "replay_game")

func replay_game():
	queue_free()
	get_node("/root/World").remove_balls()
	get_tree().change_scene("res://scenes/level1.xml")