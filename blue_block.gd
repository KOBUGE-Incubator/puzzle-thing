
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var r
const GRAVITY = 500.0
var velocity = Vector2()
var color = "blue"
var same_color_list = []
var delete = false
var falling = false
var visited = false
func _fixed_process(delta):
	velocity.y = 0
	if(falling == true):
		velocity.y += delta * GRAVITY
		set_pos(Vector2(get_pos().x, get_pos().y + velocity.y))
#	else:
#		if((r.get_collider().get_global_pos().y - get_global_pos().y) < 64):
#			velocity.y = 0
#			#This little bit of code is only important in the y direction
#			#What it does is make sure that the block is sitting on a position that is divisible by 64
#			#ensuring that there are no gaps in between blocks.
	else:
		print(get_global_pos().y)
#		set_global_pos(Vector2(get_global_pos().x, ))
#		else:
#			r.set_cast_to(Vector2(0, 0))
#			set_pos(Vector2(get_pos().x, get_pos().y + velocity.y))



	
func _ready():
	color = get_name().split('_')[0]
	set_contact_monitor(true)
	set_fixed_process(true)

