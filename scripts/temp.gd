
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var falling = false
var count = 0
var t = 0
func _process(delta):
	t += delta
	check_level()
	
func check_if_falling():
	for block in get_children():
		if block.falling == true:
			_exit_tree()
			return true
	return false

func check_level():
	for block in get_children():
		if not block.falling:
#			check_level_recur(block)
	#		if not block.delete:
	#			for i in block.get_colliding_bodies():
	#				if (i.get_type() == "RigidBody2D" and i.color == block.color):
	#					block.same_color_list.append(i)
	#			if(block.same_color_list.size() >= 4):
	#				block.delete = true
	#				for x in block.same_color_list:
	#					block.delete = true
	#		else:
	#			pass
			var color_list = []
			for block in get_children():
				if block.visited == true:
					color_list.append(block)
			if color_list.size() >= 3:
				for i in color_list:
					i.queue_free()
			else:
				for x in color_list:
					x.visited = false
		set_process(true)

#I'm going to try and use this count thing to flip a flag and then trickle that up to the root node...
func check_level_recur(block):
	for b in block.get_colliding_bodies():

		if(b.get_type() == "RigidBody2D" and b.get_name() != 'RigidBody2D'):
			if b.color == block.color and b.visited == false:
				b.visited = true
				check_level_recur(b)

func _ready():
	set_process(true)


