
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var falling = false
var count = 0
var t = 0

func _fixed_process(delta):
	t += delta
#	if not check_if_falling():
#		for block in get_children():
#			check_level_recur(block)
#		delete_blocks()
#		set_process(false)
	for block in get_children():
#		block.get_node("Label").set_text(block.color)
		block.get_node("Label").set_text(block.get_name().split("_")[1])
#		block.get_node("Label").set_text(str(block.delete))

	
func check_if_falling():
	for block in get_children():
		if block.falling == true:
			return true
	return false

func delete_blocks():
	var color_list = []
	for block in get_children():
		if block.delete == true:
			color_list.append(block)

	if color_list.size() >= 4:
		for i in color_list:
			i.queue_free()
	else:
		for x in color_list:
			x.visited = false
			x.delete = false

#I'm going to try and use this count thing to flip a flag and then trickle that up to the root node...
func check_level_recur(block):
	print('----------------------')
	print("From")
	print(block.get_name())
	print('bot', block.b)
	print('top', block.t)
	print('left', block.l)
	print('right', block.r)
	
#	for b in blocks:
#		print("to")
#		print(b.get_name())
#		if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
#			if b.color == block.color:
#				b.delete = true
#				block.delete = true
#			if b.color == block.color and b.visited == false:
#				check_level_recur(b, count + 1)

	if(block.l != null):
		check_block(block.l, block)
	if(block.r != null):
		check_block(block.r, block)
	if(block.t != null):
		check_block(block.t, block)
	if(block.b != null):
		check_block(block.b, block) 
		
func check_block(b, block):
	var wf = weakref(b)
	if wf.get_ref() != null:
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
	set_fixed_process(true)


