
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var screen_width

func _process(delta):
	set_global_pos(Vector2(screen_width, get_global_pos().y))
func _ready():
	screen_width = get_parent().level_width + 20
	set_process(true)