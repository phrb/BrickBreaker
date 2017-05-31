extends Node2D

const simple_brick_scene         = preload("res://scenes/brick.xml")

export var simple_brick_children = 130

var starting_x = 76
var starting_y = 128
var step_x     = 64
var step_y     = 28

var child_pos  = Vector2(starting_x, starting_y)

func _ready():
	for i in range(simple_brick_children):
		var simple_brick_node = simple_brick_scene.instance()
		simple_brick_node.set_pos(child_pos)
		get_node(".").add_child(simple_brick_node)
		
		if child_pos.x + (2 * step_x) >= get_viewport().get_rect().size.x:
			child_pos.x  = starting_x
			child_pos.y += step_y
		else:
			child_pos.x += step_x
	
	for child in get_children():
		child.add_to_group("Bricks")