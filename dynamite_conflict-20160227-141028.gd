
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var fuse_length = 0
var time_elapsed = 0 

func _process(delta):
	if(fuse_length < time_elapsed):
		print("BOOM")
	time_elapsed += delta

func _ready():
	set_process(true)

