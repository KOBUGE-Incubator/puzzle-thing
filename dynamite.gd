
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

#bombs
var bomb_size = 20
var bomb_queue = []
var L
var T
var bomb_list
#Explosions

func explosion():
	add_child(bomb_list[rand_range(0,1)])
	
func _on_Area2D_body_enter(body):
	if(body.get_type() == "KinematicBody2D"):
		pass
	else:
		explosion()

func _on_Area2D_body_exit(body):
	if(body.get_type() == "KinematicBody2D"):
		pass
	else:
		queue_free()

func _ready():
	L = preload("res://L_explosion.scn").instance()
	bomb_list = [L, T]
	set_process(true)
	get_node("Area2D").connect("body_enter",self,"_on_Area2D_body_enter")
	get_node("Area2D").connect("body_exit",self,"_on_Area2D_body_exit")


	


