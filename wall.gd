
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _left_wall_collide(body):
	if(body.get_type() == "KinematicBody2D"):
		body.direction = "right"
func _right_wall_collide(body):
	if(body.get_type() == "KinematicBody2D"):
		body.direction = "left"
func _ready():
	get_parent().get_node("Wall").connect("body_enter",self,"_left_wall_collide")
	get_parent().get_node("Wall 2").connect("body_exit",self,"_right_wall_collide")

