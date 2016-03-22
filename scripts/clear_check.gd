
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var falling = false
var count = 0
var t = 0
var same_color_list = []

func _process(delta):
	t += delta
	for block in get_children():
		block.get_node("Label").set_text(block.get_name().split("yellow")[1])

	
func check_if_falling():
	for block in get_children():
		if block.falling == true:
			return true
	return false

func check_level(block):
	check_level_recur(block, 0)
	var color_list = []

	for block in get_children():
		if block.visited == true:
			color_list.append(block)
	for node in color_list:
		print(node.get_name())
	if color_list.size() >= 4:
		for i in color_list:
			i.queue_free()
	else:
		print(color_list)
		for x in color_list:
			x.visited = false
		color_list = []

#I'm going to try and use this count thing to flip a flag and then trickle that up to the root node...
func check_level_recur(block, count):
	print(block.get_colliding_bodies())
	var blocks = block_colliding_bodies(block)
	block.visited = true
	for b in blocks:
		if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
			if b.color == block.color and b.visited == false:
				return check_level_recur(b, count + 1)
				
	

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


