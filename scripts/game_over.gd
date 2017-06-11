extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("../World/Paddle").game_over = true
	get_node("high_score").set_text(str(get_node("/root/World").high_score))
	get_node("your_score").set_text(str(get_node("/root/World").score))
	
	get_node("play").connect("pressed", self, "replay_game")
	get_node("menu").connect("pressed", self, "go_to_menu")

func replay_game():
	queue_free()
	get_node("/root/World").remove_balls()
	get_tree().change_scene("res://scenes/level1.xml")

func go_to_menu():
	print("You should start menu scene here")