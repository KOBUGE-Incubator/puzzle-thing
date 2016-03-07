
extends KinematicBody2D

#Constants
const GRAVITY = 200.0
const WALK_SPEED = 100.0
var velocity = Vector2()
var dino
var elapsed_time = 0
var bomb_delay = .2
var screen_size = OS.get_window_size()
var bomb_count = 10000
var time
var bomb_fuse = 0
var bomb_count_label
var is_colliding
var treasure = 0
var treasure_label

#controls
var bomb
var left
var right
var jump

#used for jumping
var jumping = false

func _fixed_process(delta):
	time = delta
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	move ( motion )
	
	if(Input.is_action_pressed(left)):
		velocity.x = -WALK_SPEED
	elif(Input.is_action_pressed(right)):
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
		jumping = true

	if (Input.is_action_pressed(bomb)):
		bomb_fuse += delta
		elapsed_time += delta

func _input(ev):
	if(ev.is_action_pressed(jump) and jumping):
		velocity.y = -200
		jumping = false
	if (ev.is_action_released(bomb) and bomb_count > 0):
		if(elapsed_time > bomb_delay):
			var bomb = dino.duplicate()
			var bomb_pos = get_global_pos()
			bomb_pos = Vector2(bomb_pos.x + 30, bomb_pos.y)
			bomb.set_global_pos(bomb_pos)
			if(get_name() == "character_2"):
				bomb.set_linear_velocity((get_global_mouse_pos() - get_global_pos()).normalized() * 500)
			else:
				bomb.set_linear_velocity(Vector2(Input.get_joy_axis(0, 2)*300, Input.get_joy_axis(0,3)*300))
			get_parent().add_child(bomb)
			elapsed_time = 0
			bomb_count += -1
			bomb_count_label.set_text("Player 1 | Bombs: " + str(bomb_count))
			bomb_fuse = 0
			
func treasure():
	treasure += 1
	treasure_label.set_text("treasure: " + str(treasure))
	bomb_count += 2
	bomb_count_label.set_text("Player 2 | Bombs: " + str(bomb_count))
	
func configure_controls():
	if(get_name() == "character_1"):
		left = "left1"
		right = "right1"
		jump = "jump1"
		bomb = "bomb1"
	elif(get_name() == "character_2"):
		left = "left2"
		right = "right2"
		jump = "jump2"
		bomb = "bomb2"
		get_node("Potatoe").queue_free()
		
		add_child(load("melrosemuligan.scn").instance())
	else:
		left = "left2"
		right = "right2"
		jump = "jump2"
		bomb = "bomb"
		get_node("Potatoe").queue_free()
		var player = load("melrosemuligan.scn")
		var new_player = player.duplicate()
		add_child(new_player)
		
func _ready():
	set_name("character_" + str(get_parent().players_added))
	configure_controls()
	set_process_input(true)
	set_global_pos(Vector2((screen_size.y /2) + 64, get_global_pos().y))
	set_fixed_process(true)
	bomb_count_label = get_parent().get_parent().get_parent().get_parent().get_node("bomb_count_1")
	bomb_count_label.set_text("Player 1 | Bombs: " + str(bomb_count))
	treasure_label = get_parent().get_parent().get_parent().get_parent().get_node("treasure_label_1")
	treasure_label.set_text("treasure: " + str(treasure))
	get_parent().get_node("Wall").connect("body_enter",self,"_left_wall_collide")
	get_parent().get_node("Wall_2").connect("body_exit",self,"_right_wall_collide")
	dino = preload("res://dynamite.scn").instance()
	add_to_group("players")
	
		
