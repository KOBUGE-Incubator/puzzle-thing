
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	if(Input.is_action_pressed("start")):
		get_node("/root/global").goto_scene("res://game.scn")
	set_global_pos(Vector2(OS.get_window_size().x/2, OS.get_window_size().y/2))
		
func _ready():
	set_process(true)



