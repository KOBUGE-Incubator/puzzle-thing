
extends KinematicBody2D

# member variables here, example:
const GRAVITY = 200.0
var velocity = Vector2()
const WALK_SPEED = 100.0
var dino
var elapsed_time = 0
var bomb_delay = .4
var direction = "left"
var screen_size = OS.get_window_size()
var camera
var time
var bomb_fuse = 0
var bomb_count = 20
var bomb_count_label
var is_colliding
var treasure = 0
var treasure_label

func _fixed_process(delta):

	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	move ( motion )
	if direction == "left":
		velocity.x = -WALK_SPEED 
	elif direction == "right":
		velocity.x = WALK_SPEED
	else:
		velocity.x = 0
		var motion = velocity * delta
		move(motion)

	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		is_colliding = true
	else:
		is_colliding = false
	time = delta
	if (Input.is_action_pressed("bomb2")):
		bomb_fuse += delta
		print("bomb", bomb_fuse)
	elapsed_time += delta
	
func _input(ev):
	if(ev.is_action_pressed("jump2") and is_colliding):
		velocity.y = -200
	if (ev.is_action_released("bomb2") and bomb_count > 0):
		if(elapsed_time > bomb_delay):
			var bomb = dino.duplicate()
			var bomb_pos = get_global_pos()
			bomb_pos = Vector2(bomb_pos.x + 30, bomb_pos.y)
			bomb.set_global_pos(bomb_pos)
			bomb.set_linear_velocity(Vector2(velocity.x *.5, velocity.y*2))
			get_parent().add_child(bomb)
			bomb.fuse_length=bomb_fuse
			elapsed_time = 0
			bomb_count += -1
			bomb_count_label.set_text("Player 2 | Bombs: " + str(bomb_count))
			bomb_fuse = 0
func treasure():
	treasure += 1
	treasure_label.set_text("treasure: " + str(treasure))
	bomb_count += 2
	bomb_count_label.set_text("Player 2 | Bombs: " + str(bomb_count))
	
func _ready():
	bomb_count_label = get_parent().get_parent().get_parent().get_parent().get_node("bomb_count_2")
	bomb_count_label.set_text("Player 2 | Bombs: " + str(bomb_count))
	treasure_label = get_parent().get_parent().get_parent().get_parent().get_node("treasure_label_2")
	treasure_label.set_text("treasure: " + str(treasure))
	
	set_process_input(true)
	set_global_pos(Vector2((screen_size.y /2) - 64, get_global_pos().y))
	set_fixed_process(true)
	get_parent().get_node("Wall").connect("body_enter",self,"_left_wall_collide")
	get_parent().get_node("Wall_2").connect("body_exit",self,"_right_wall_collide")
	dino = preload("res://dynamite.scn").instance()

