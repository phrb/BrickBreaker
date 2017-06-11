extends Node2D

func _ready():
	get_node("Random").connect("pressed", self, "random_level")
	get_node("Easy").connect("pressed", self, "easy_level")
	get_node("Medium").connect("pressed", self, "medium_level")
	get_node("Hard").connect("pressed", self, "hard_level")

func random_level():
	global.level = randi() % 3
	get_tree().change_scene("res://scenes/level1.xml")
	queue_free()

func easy_level():
	global.level = 0
	get_tree().change_scene("res://scenes/level1.xml")
	queue_free()
	
func medium_level():
	global.level = 1
	get_tree().change_scene("res://scenes/level1.xml")
	queue_free()
	
func hard_level():
	global.level = 2
	get_tree().change_scene("res://scenes/level1.xml")
	queue_free()