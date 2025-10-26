extends Node2D

var hp = 1

signal player_die


var score = 0

#data
var closest_bullet = null


#parameters
var left_number = 0
var right_number = 0
var front_number = 0
var back_number = 0
var angle_to_closest_bullet = 0
var distance_from_closest_bullet = 10000
var left_has_more_bullets = false
var right_has_more_bullets = false
var front_has_more_bullets = false
var back_has_more_bullets = false
var how_long_closest_bullet_has_been_closest = 0

var python_path = "C:\\Users\\Juneb\\Documents\\GitHub\\knighthacks25\\PythonScripts\\env\\Scripts\\python.exe"
var script_path = "C:\\Users\\Juneb\\Documents\\GitHub\\knighthacks25\\PythonScripts\\your_script.py"


#func _ready() -> void:
	#for i in range(0,20):
		#await get_tree().create_timer(0.5).timeout
		#move_right()
	
var frame_count = 0
var frame_limit = 15  # Send state every 5 frames
	
func _physics_process(_delta: float) -> void:
	
	if(hp <= 0):
		die()
	
	#update data
	if(closest_bullet):
		angle_to_closest_bullet = get_angle_to(closest_bullet.position)
		distance_from_closest_bullet = position.distance_to(closest_bullet.position)
		how_long_closest_bullet_has_been_closest += 1

	
	if(right_number > left_number):
		right_has_more_bullets = true
		left_has_more_bullets = false
	if(right_number < left_number):
		right_has_more_bullets = false
		left_has_more_bullets = true
	
	if(front_number > back_number):
		front_has_more_bullets = true
		back_has_more_bullets = false
	if(front_number < back_number):
		front_has_more_bullets = false
		back_has_more_bullets = true
		
	#print(distance_from_closest_bullet)
	#print(angle_to_closest_bullet)
	#print(left_number)
	#print(right_number)
	#print(front_number)
	#print(back_number)
	#print(how_long_closest_bullet_has_been_closest)
	
	#if(left_has_more_bullets || right_has_more_bullets || front_has_more_bullets || back_has_more_bullets):
	#print(left_has_more_bullets)
	#print(right_has_more_bullets)
	#print(front_has_more_bullets)
	#print(back_has_more_bullets)
		
	frame_count += 1
	if frame_count % frame_limit ==0:
		send_state(distance_from_closest_bullet)	
	score += 1
		
	
func die():
	player_die.emit()
	#gameover()
	pass
	
func move_left():
	position.x -= 5
	
func move_right():
	position.x += 5
	
func move_up():
	position.y -= 5
	
func move_down():
	position.y += 5
	
func send_state(state: float):
	
	var args = [str(state)]
	var command = [python_path, script_path] + args
	var output = []
	print("Sending state: " + str(state))
	OS.execute(command[0], command.slice(1), output)
	move()

func read_action():
	var file = FileAccess.open("C:\\Users\\Juneb\\Documents\\GitHub\\knighthacks25\\PythonScripts\\action.txt", FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var action = int(text.strip_edges())
	return action
	
func move():
	var action = read_action()
	print (action)
	match action:
		0: move_left()
		1: move_right()
		2: move_up()
		3: move_down()
		
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	body.queue_free()
	hp -= 1
	print(hp)
	

func update_closest_bullet(new_bullet):
	if(closest_bullet != new_bullet):
		how_long_closest_bullet_has_been_closest = 0
		
	closest_bullet = new_bullet

func update_left_number(new_number):
	left_number = new_number
	
func update_right_number(new_number):
	right_number = new_number
	
func update_front_number(new_number):
	front_number = new_number
	
func update_back_number(new_number):
	back_number = new_number
#func gameover():
	#get_tree().reload_current_scene()
