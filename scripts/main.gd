tool
extends Node2D

var level_size = 500
var level_width = 750
#terrain
var screen_size
var terrain = []
var blue_block
var red_block
var green_block
var yellow_block
var x_offset = 64
var y_offset = 128

#player sutff
var player_count = 2
var players_added = 0


func _ready():
	
	#terrain
	blue_block = preload("res://scenes/blue_block.tscn").instance()
	red_block = preload("res://scenes/red_block.tscn").instance()
	green_block = preload("res://scenes/green_block.tscn").instance()
	yellow_block = preload("res://scenes/yellow_block.tscn").instance()
	screen_size = OS.get_window_size()
	terrain.append(blue_block)
	terrain.append(red_block)
	terrain.append(green_block)
	terrain.append(yellow_block)
	generate_terrain()
	var wall_2 = get_node("Wall_2")
	wall_2.set_global_pos(Vector2(screen_size.x-700, wall_2.get_global_pos().y))
	set_process(true)
	get_parent().set_transparent_background(true)
	
	#Add characters
	generate_characters()
	
func generate_characters():
	for x in range(0, player_count):
		var player = preload("res://scenes/character.tscn").instance()
		var new_player = player.duplicate()
		players_added += 1
		new_player.set_name("character_" + str(x))
		add_child(new_player)
	get_node("Camera2D").load_camera()

	
func generate_terrain():
	var node
	var level = get_node("level")
	for i in range(0, level_size):
		randomize()
		node = terrain[rand_range(0,4)].duplicate()
		node.translate(Vector2(x_offset, y_offset))
		level.add_child(node)
		#For some reason, if this is set to 64 the fifth column is screwed up somehow.
		x_offset += 64
		if(x_offset > (level_width)):
			x_offset = 64
			y_offset += 64.5
	get_node("floor").set_global_pos(Vector2(get_node("floor").get_global_pos().x, y_offset+64))





