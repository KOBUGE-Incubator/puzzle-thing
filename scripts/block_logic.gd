extends RigidBody2D

const GRAVITY = 200.0
var velocity = Vector2()
var color = 'blue'
var falling = true
var visited = false
var bottom
var delete = false

var right
var left
var bot
var top

var l
var r
var b
var t

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	if falling == true:
		set_pos(Vector2(get_pos().x, get_pos().y + 2))
	
	if(right.get_collider() != null and right.get_collider().get_type() == "RigidBody2D" and right.get_collider().get_name() != 'RigidBody2D'):
		r = right.get_collider()
	if(left.get_collider() != null and left.get_collider().get_type() == "RigidBody2D" and left.get_collider().get_name() != 'RigidBody2D'):
		l = left.get_collider()
	if(top.get_collider() != null and top.get_collider().get_type() == "RigidBody2D" and top.get_collider().get_name() != 'RigidBody2D'):
		t = top.get_collider()
	if(bot.get_collider() != null and bot.get_collider().get_type() == "RigidBody2D" and bot.get_collider().get_name() != 'RigidBody2D'):
		b = bot.get_collider()
		

#Signals are used to control start and stop falling
func _on_Area2D_body_enter(body):
	falling = false
	if(body.get_type() == "RigidBody2D" and body.get_name() != 'RigidBody2D'):
		get_parent().check_level_recur(self)
		get_parent().delete_blocks()

func _on_Area2D_body_exit(body):
	falling = true

		
#Helper function to check if the body is another block
func check_block(body):
	if(body.get_type() == "RigidBody2D" and body.get_name() != 'RigidBody2D'):
		return body
	else:
		return null

func _ready():
	bottom = get_node("bottom")
	set_fixed_process(true)
	
	right = get_node('right')
	left = get_node('left')
	top = get_node('top')
	bot = get_node('bot')
	
	bottom.connect("body_enter",self,"_on_Area2D_body_enter")
	bottom.connect("body_exit",self,"_on_Area2D_body_exit")
	
	if(get_name()[0] == "@"):
		color = get_name().split("_")[0].split("@")[1]
	else:
		color = get_name().split("_")[0]