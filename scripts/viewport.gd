
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	set_size(Vector2(OS.get_window_size()))

func _ready():
	set_process(true)



