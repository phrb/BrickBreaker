extends Node2D

const simple_brick_scene = preload("res://scenes/brick.xml")

var brick_matrix_x = 30
var brick_matrix_y = 13

var fringe_1_start = 0
var fringe_2_start = 20
var fringe_size    = 5

var shell_1_start = 6
var shell_2_start = 18
var shell_size    = 1

var body_1_start = 8
var body_2_start = 14
var body_size    = 3

var core_start = 12
var core_size  = 1

var easy_level = { 'fringe_1': 0.0,
                   'shell_1':  0.1,
                   'body_1':   0.9,
                   'core':     1.0,
                   'body_2':   0.3,
                   'shell_2':  0.1,
                   'fringe_2': 0.01,
                   'brick_ps': [0.10, 0.20] }

var medium_level = { 'fringe_1': 0.05,
                     'shell_1':  0.7,
                     'body_1':   0.9,
                     'core':     0.3,
                     'body_2':   0.9,
                     'shell_2':  0.7,
                     'fringe_2': 0.05,
                     'brick_ps': [0.2, 0.4] }

var hard_level = { 'fringe_1': 0.12,
                   'shell_1':  1.0,
                   'body_1':   0.5,
                   'core':     1.0,
                   'body_2':   0.7,
                   'shell_2':  1.0,
                   'fringe_2': 0.5,
                   'brick_ps': [0.4, 0.8] }

var levels = [easy_level, medium_level, hard_level]
var probabilities

var starting_x = 76
var starting_y = 128
var step_x     = 64
var step_y     = 28

var brick_matrix = []

var child_pos  = Vector2(starting_x, starting_y)


func _ready():
	probabilities = [[fringe_1_start, fringe_1_start + fringe_size, levels[global.level]['fringe_1']],
                     [shell_1_start,  shell_1_start + shell_size,   levels[global.level]['shell_1']],
                     [body_1_start,   body_1_start + body_size,     levels[global.level]['body_1']],
                     [core_start,     core_start + core_size,       levels[global.level]['core']],
                     [body_2_start,   body_2_start + body_size,     levels[global.level]['body_2']],
                     [shell_2_start,  shell_2_start + shell_size,   levels[global.level]['shell_2']],
                     [fringe_2_start, brick_matrix_x - 1,           levels[global.level]['fringe_2']]]
	randomize()
	var die = randf()
	
	var add_brick_probability = 0
	for x in range(brick_matrix_x):
		brick_matrix.append([])
		
		for y in range(brick_matrix_y):
			brick_matrix[x].append([])
			
			for probability in probabilities:
				if x >= probability[0] and x <= probability[1]:
					add_brick_probability = probability[2]
					
			if die < add_brick_probability:
				brick_matrix[x][y] = 1
				
				var simple_brick_node = simple_brick_scene.instance()
				simple_brick_node.set_prob(levels[global.level]['brick_ps'])
				simple_brick_node.set_pos(child_pos)
				simple_brick_node.add_to_group("Bricks")
				
				get_node(".").add_child(simple_brick_node)
			else:
				brick_matrix[x][y] = 0
		
			if child_pos.x + (2 * step_x) >= get_viewport().get_rect().size.x:
				child_pos.x  = starting_x
				child_pos.y += step_y
			else:
				child_pos.x += step_x
			
			die = randf()