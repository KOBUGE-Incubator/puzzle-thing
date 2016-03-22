extends RigidBody2D

const GRAVITY = 200.0
var velocity = Vector2()
var color = 'blue'
var falling = true
var visited = false
var bottom
var delete = false
func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	if falling == true:
		set_pos(Vector2(get_pos().x, get_pos().y + 2))

#Signals are used to control start and stop falling
func _on_Area2D_body_enter(body):
	falling = false
	get_parent().check_level(self)

func _on_Area2D_body_exit(body):
	falling = true

func _ready():
	bottom = get_node("bottom")
	set_fixed_process(true)
	
	bottom.connect("body_enter",self,"_on_Area2D_body_enter")
	bottom.connect("body_exit",self,"_on_Area2D_body_exit")
	if(get_name()[0] == "@"):
		color = get_name().split("_")[0].split("@")[1]
	else:
		color = get_name().split("_")[0]