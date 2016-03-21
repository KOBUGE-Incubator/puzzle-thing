extends KinematicBody2D

var falling = false
var visited = false
func _fixed_process(delta):
	pass

func _ready():
	set_fixed_process(true)
	