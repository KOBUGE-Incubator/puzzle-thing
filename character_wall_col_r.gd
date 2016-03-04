#extends Area2D
#
# member variables here, example:
# var a=2
# var b="textvar"
#
#func _left_wall_collide(body):
#	if(not body.get_type() == "RigidBody2D"):
#		get_parent().direction = "left"
#		get_parent().get_node("Potatoe/AnimationPlayer").play("rotate")
#func _ready():
#	connect("body_enter",self,"_left_wall_collide")
#
#