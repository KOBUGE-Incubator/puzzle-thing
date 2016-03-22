
extends Viewport

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var screen = OS.get_window_size()
	set_rect(Rect2(0, 0, screen.x, screen.y))
	get_camera()
