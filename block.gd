
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"
#func _on_Area2D_body_enter(body):
#	get_parent().falling = false
#	
#func _on_Area2D_body_exit(body):
#	get_parent().falling = true

func _ready():
	connect("body_enter",self,"_on_Area2D_body_enter")
	connect("body_exit",self,"_on_Area2D_body_exit")


