
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var carrot
var treasure = true
func explode():
	var node = carrot.duplicate()
	node.set_global_pos(get_global_pos())
	get_parent().get_parent().add_child(node)
	queue_free()
	
func _ready():
	carrot = preload("res://carrot.scn").instance()


