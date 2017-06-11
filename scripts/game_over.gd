extends Node2D

const menu_scene = preload("res://scenes/menu.xml")

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
	var world_node = get_node("/root/World")
	
	world_node.get_node("HighScore").hide()
	world_node.get_node("Score").hide()
	world_node.get_node("Combo").hide()
	world_node.get_node("MaxCombo").hide()
	
	world_node.remove_balls()
	world_node.remove_bricks()
	world_node.remove_paddle()
	
	var menu_node = menu_scene.instance()
	get_node("..").add_child(menu_node)
	queue_free()