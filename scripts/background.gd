extends Sprite

var rotation_factor = 512 setget scale_rotation_by
var min_rotation_factor = 0.5

var color_factor    = 0.2 setget scale_color_by

func reset_rotation():
	rotation_factor = 512
	
func reset_color():
	color_factor = 0.2

func scale_color_by(factor):
	color_factor *= factor

func scale_rotation_by(factor):
	rotation_factor = max(rotation_factor / factor, min_rotation_factor)

func _ready():
	randomize()
	set_fixed_process(true)
	
func _fixed_process(delta):
	var rotation_delta = delta / rotation_factor
	var color_delta    = delta * color_factor
	
	if randf() >= 0.5:
		color_delta *= -1
	
	set_rot(get_rot() + rotation_delta)
	var current_color = get_modulate()
	
	var colors = [Color(current_color.r + color_delta, current_color.g, current_color.b),
	              Color(current_color.r, current_color.g + color_delta, current_color.b),
	              Color(current_color.r, current_color.g, current_color.b + color_delta),
                  Color(current_color.r + color_delta, current_color.g + color_delta, current_color.b),
	              Color(current_color.r, current_color.g + color_delta, current_color.b + color_delta),
	              Color(current_color.r + color_delta, current_color.g, current_color.b + color_delta)]
	
	set_modulate(colors[randi() % colors.size()])