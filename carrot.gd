
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
func _on_Area2D_body_exit(body):
	pass
func _on_Area2D_body_enter(body):
	print(body.get_name())
	if(body.get_name() == "character_1"):
		get_parent().get_parent().get_node("Node2D").get_node("character_1").treasure()
		queue_free()
	if(body.get_name() == "character_2"):
		get_parent().get_parent().get_node("Node2D").get_node("character_2").treasure()
		queue_free()

func _ready():
	get_node("Area2D").connect("body_enter",self,"_on_Area2D_body_enter")
	get_node("Area2D").connect("body_exit",self,"_on_Area2D_body_exit")