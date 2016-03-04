
extends Camera2D

# member variables here, example:
# var a=2
# var b="textvar"
var character_1
var character_2
var screen_size
var level_width
var combined_character_distance

func _process(delta):
	combined_character_distance = character_1.get_global_pos().distance_to(character_2.get_global_pos())

	if(character_1.get_global_pos().y > character_2.get_global_pos().y):
		set_global_pos(Vector2(get_global_pos().x, (character_1.get_global_pos().y + character_2.get_global_pos().y)/2))
	else:
		set_global_pos(Vector2(get_global_pos().x, (character_2.get_global_pos().y + character_1.get_global_pos().y)/2))
	if(combined_character_distance > screen_size.y/1.5 ):
		set_zoom(Vector2(combined_character_distance*1.5 / screen_size.y, combined_character_distance*1.5 / screen_size.y))
	set_offset(Vector2(level_width/2, (screen_size.y/2) - (screen_size.y /3.5)))


func load_camera():
	character_1 = get_parent().get_node("character_1")
	character_2 = get_parent().get_node("character_2")
	screen_size = OS.get_window_size()
	level_width = get_parent().level_width
	set_process(true)


