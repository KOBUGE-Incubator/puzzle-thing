
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
		block.get_node("Label").set_text(block.get_name().split("_")[1])
#		block.get_node("Label").set_text(block.color)

	
func check_if_falling():
	for block in get_children():
		if block.falling == true:
			return true
	return false

func check_level(block):
	print("--------------------")
	check_level_recur(block, 0)
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
	color_list = []

#I'm going to try and use this count thing to flip a flag and then trickle that up to the root node...
func check_level_recur(block, count):
	var blocks = block_colliding_bodies(block)
	block.visited = true
	print("From")
	print(block.get_name())
	for b in blocks:
		print("to")
		print(b.get_name())
		if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
			if b.color == block.color:
				b.delete = true
				block.delete = true
			if b.color == block.color and b.visited == false:
				check_level_recur(b, count + 1)
			else:
				return
				
	

func block_colliding_bodies(block):
	var col = []
	if(block.get_node("bot").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("bot").get_overlapping_bodies()[0])
	if(block.get_node("top").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("top").get_overlapping_bodies()[0])
	if(block.get_node("left").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("left").get_overlapping_bodies()[0])
	if(block.get_node("right").get_overlapping_bodies().size() > 0):
		col.append(block.get_node("right").get_overlapping_bodies()[0])
	return col

func _ready():
	set_process(true)


