extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.


export var RIGHT_KEY = KEY_UP
export var LEFT_KEY = KEY_LEFT
export var UP_KEY = KEY_RIGHT
export var IS_AI = false
export var delay = 100
export var follow = ""
var bullet = preload("res://Bullet.tscn")
var memory = []
var the_other



func _ready():
	print(KEY_W)#87
	print(RIGHT_KEY)
	print(LEFT_KEY)
	print(UP_KEY)
	
	if IS_AI:
		print("AI")

		the_other = get_tree().get_root().find_node(follow, true, false)
		for i in range(100):
	       	memory.append(Vector2(0,0))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var motion = Vector2()
var motionx = 0
var motiony = 0
var animation = "idle"
onready var sprite = get_node("Sprite")
const max_speed = 400
const jump_speed = -405
var bulletCounter = 0

const UP = Vector2(0, -1) 
var jumps = 0
var jumpTime = 0
var counter = -99
func _physics_process(delta):

	if not IS_AI:
		motion.y += 700*delta
		if Input.is_key_pressed(RIGHT_KEY):
			motion.x = max_speed
		elif Input.is_key_pressed(LEFT_KEY):
			motion.x = -max_speed
		else:
			motion.x = 0
				
		if Input.is_key_pressed(UP_KEY):
			if is_on_floor():
				motion.y = jump_speed
				jumps = 0
				jumpTime = OS.get_ticks_msec()
			elif jumps == 0 and (OS.get_ticks_msec() - jumpTime) > 200:
				jumps = 1
				motion.y = jump_speed
		move_and_slide(motion, UP)
	else:
	
		if counter > 200:
			counter = 0
			var nodeInstance = bullet.instance()
			get_tree().get_root().add_child(nodeInstance)
			nodeInstance.position = position
			bulletCounter = bulletCounter + 2
			get_parent().get_node("CanvasLayer").get_node("Label").set_text('bullets: '+str(bulletCounter))
			nodeInstance.direction = position.direction_to(get_tree().get_root().find_node("Player", true, false).position)
		counter += 1
		memory.append(the_other.position)
		motion = memory[0] - position
		position = memory[0] 
		memory.remove(0)
	
		
	
	
	if motion.x == 0:
		animation = "idle"
	else:
		animation = "running"
	
	if motion.x > 0:
		sprite.set_flip_h(false)
	elif motion.x < 0:
		sprite.set_flip_h(true)
	sprite.play(animation)
	pass

func _on_Area2D_area_entered(area):
	if IS_AI:
		return
	if area.name == "Gem":
		get_tree().change_scene("res://WinScene.tscn")
	else:
		get_tree().change_scene("res://DeathScreen.tscn")
	pass # Replace with function body.
