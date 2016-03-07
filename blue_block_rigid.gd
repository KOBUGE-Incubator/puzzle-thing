
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var r
const GRAVITY = 50.0
var velocity = Vector2()
func _fixed_process(delta):
	velocity.y += delta * GRAVITY

	
func _ready():
	set_fixed_process(true)

