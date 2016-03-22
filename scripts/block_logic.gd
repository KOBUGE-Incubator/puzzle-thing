extends RigidBody2D

const GRAVITY = 200.0
var velocity = Vector2()

var falling = true
var visited = false
var bottom
func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	if falling == true:
		set_pos(Vector2(get_pos().x, get_pos().y + 2))

#Signals are used to control start and stop falling
func _on_Area2D_body_enter(body):
	falling = false

func _on_Area2D_body_exit(body):
	falling = true

func _ready():
	bottom = get_node("bottom")
	set_fixed_process(true)
	
	bottom.connect("body_enter",self,"_on_Area2D_body_enter")
	bottom.connect("body_exit",self,"_on_Area2D_body_exit")
	get_name()