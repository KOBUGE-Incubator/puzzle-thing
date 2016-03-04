
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var r
const GRAVITY = 50.0
var velocity = Vector2()
func _process(delta):
	velocity.y += delta * GRAVITY
	if(r.get_collider() == null):
		r.set_cast_to(r.get_cast_to() + Vector2(0, 64))
	else:
		if((r.get_collider().get_global_pos().y - get_global_pos().y) < 65):
			velocity.y = 0
			#This little bit of code is only important in the y direction
			#What it does is make sure that the block is sitting on a position that is divisible by 64
			#ensuring that there are no gaps in between blocks.
			if(int(get_global_pos().y) % 64 != 0):
				set_global_pos(Vector2(get_global_pos().x, (int(get_global_pos().y) - (int(get_global_pos().y) % 64) )))
		else:
			r.set_cast_to(Vector2(0, 0))
			set_pos(Vector2(get_pos().x, get_pos().y + velocity.y))


	
func _ready():
	r = get_node("RayCast2D")
	set_process(true)

