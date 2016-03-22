tool
extends Node2D

var level_size = 200
var level_width = 500
#terrain
var dirt
var treasure
var rock
var screen_size
var terrain = []
var dirt_2
var dirt_4
var dirt_3
var x_offset = 64
var y_offset = 128
var treasure_count = 0
var game_end
var player_count = 2
var players_added = 0
func _ready():
	#terrain
	dirt = preload("res://blue_block.scn").instance()
	treasure = preload("res://red_block.scn").instance()
	dirt_2 = preload("res://green_block.scn").instance()
	dirt_3 = preload("res://green_block.scn").instance()
	dirt_4 = preload("res://yellow_block.scn").instance()
	screen_size = OS.get_window_size()
	terrain.append(dirt)
	terrain.append(dirt_2)
	terrain.append(dirt_3)
	terrain.append(dirt_4)
	terrain.append(treasure)
	generate_terrain()
	var wall_2 = get_node("Wall_2")
	wall_2.set_global_pos(Vector2(screen_size.x-700, wall_2.get_global_pos().y))
	set_process(true)
	get_parent().set_transparent_background(true)
	
	#Add characters
	generate_characters()
	
func generate_characters():
	for x in range(0, player_count):
		var player = preload("res://character.tscn").instance()
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
		node = terrain[rand_range(0,5)].duplicate()
		node.translate(Vector2(x_offset, y_offset))
		level.add_child(node)
		#For some reason, if this is set to 64 the fifth column is screwed up somehow.
		x_offset += 63
		if(x_offset > (level_width)):
			x_offset = 64
			y_offset += 64
	get_node("floor").set_global_pos(Vector2(get_node("floor").get_global_pos().x, y_offset+128))





