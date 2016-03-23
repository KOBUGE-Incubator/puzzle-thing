
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var falling = false
var count = 0
var t = 0

func _process(delta):
	t += delta
	for block in get_children():
#		block.get_node("Label").set_text(block.color)
		block.get_node("Label").set_text(block.get_name().split("_")[1])
#		block.get_node("Label").set_text(str(block.delete))

	
func check_if_falling():
	for block in get_children():
		if block.falling == true:
			return true
	return false

func check_level(block):
	print("--------------------")
	var block_list
	check_level_recur(block)
	block.get_node("Label").set_text(str(block.delete))
	var color_list = []

	for block in get_children():
		if block.delete == true:
			color_list.append(block)
	print("color LIST")
	for node in color_list:
		print(node.get_name())
	if color_list.size() >= 4:
		for i in color_list:
			i.queue_free()
	else:
		print(color_list)
		for x in color_list:
			x.visited = false
			x.delete = false
	color_list.clear()

#I'm going to try and use this count thing to flip a flag and then trickle that up to the root node...
func check_level_recur(block):
	var blocks = block_colliding_bodies(block)
	print("From")
	print(block.get_name())
	print('bot', blocks[0])
	print('top', blocks[1])
	print('left', blocks[2])
	print('right', blocks[3])
	
#	for b in blocks:
#		print("to")
#		print(b.get_name())
#		if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
#			if b.color == block.color:
#				b.delete = true
#				block.delete = true
#			if b.color == block.color and b.visited == false:
#				check_level_recur(b, count + 1)

	if(blocks[0] != null):
		check_block(blocks[0], block)
	if(blocks[1] != null):
		check_block(blocks[1], block)
	if(blocks[2] != null):
		check_block(blocks[2], block)
	if(blocks[3] != null):
		check_block(blocks[3], block) 
		
func check_block(b, block):
	if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
			if b.color == block.color and b.visited == false:
				b.delete = true
				b.visited = true
				block.delete = true
				check_level_recur(b)
	
		
			

func block_colliding_bodies(block):
	var col = []
	if(block.get_node("bot").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("bot").get_overlapping_bodies()[0])
	else:
		col.append(null)
	if(block.get_node("top").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("top").get_overlapping_bodies()[0])
	else:
		col.append(null)
	if(block.get_node("left").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("left").get_overlapping_bodies()[0])
	else:
		col.append(null)
	if(block.get_node("right").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("right").get_overlapping_bodies()[0])
	else:
		col.append(null)
	return col

func _ready():
	set_process(true)


