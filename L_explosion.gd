
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _on_Area2D_body_enter( body ):
	if(body.get_type() == "KinematicBody2D"):
		body.set_global_pos(Vector2(body.get_global_pos().x, 0)) = 0
	elif(body.get_name() == "floor"):
		pass
	elif(body.get_name().find("treasure") == 1):
		body.explode()
	elif(body.get_name().find("carrot") == 1):
		pass
	elif(body.get_name() == "carrot"):
		pass
	elif(body.get_name() == "Wall"):
		pass
	elif(body.get_name() =="Wall_2"):
		pass
	else:
		print(body.get_name())
		body.queue_free()
	print(body.get_name())

func _ready():
	connect("body_enter",self,"_on_Area2D_body_enter")
	connect("body_exit",self,"_on_Area2D_body_exit")

	


