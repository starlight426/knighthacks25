extends CharacterBody2D

var score = 0

var bullet_scn = preload("res://bullet.tscn")
var angle_to_player = 0
@onready var player = get_parent().get_node("Player")
var moving: bool 
var move_dir = -1
var speed = 100

func _ready() -> void:
	moving = true
	move_loop()
	
	while(true):
		await get_tree().create_timer(0.5).timeout
		
		for i in range(0,5):
			await get_tree().create_timer(0.7).timeout
			shoot(angle_to_player,300)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,5):
			await get_tree().create_timer(0.8).timeout
			shoot(angle_to_player,300)
			shoot(angle_to_player+PI/8,300)
			shoot(angle_to_player-PI/8,300)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,3):
			await get_tree().create_timer(1.2).timeout
			shoot(angle_to_player+PI/8,300)
			shoot(angle_to_player-PI/8,300)
			shoot(angle_to_player+PI/24,300)
			shoot(angle_to_player-PI/24,300)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,7):
			await get_tree().create_timer(0.5).timeout
			shoot(angle_to_player,500)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,5):
			await get_tree().create_timer(0.7).timeout
			shoot(angle_to_player+PI/12,400)
			shoot(angle_to_player-PI/12,400)
			await get_tree().create_timer(0.1).timeout
			shoot(angle_to_player+PI/12,400)
			shoot(angle_to_player-PI/12,400)
			await get_tree().create_timer(0.1).timeout
			shoot(angle_to_player+PI/12,400)
			shoot(angle_to_player-PI/12,400)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,7):
			await get_tree().create_timer(0.8).timeout
			shoot(angle_to_player,500)
		
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,3):
			await get_tree().create_timer(1.2).timeout
			shoot(angle_to_player,300)
			shoot(angle_to_player+PI/8,400)
			shoot(angle_to_player-PI/8,400)
			shoot(angle_to_player+PI/16,400)
			shoot(angle_to_player-PI/16,400)
			
		await get_tree().create_timer(1.0).timeout
		
		for i in range(0,5):
			await get_tree().create_timer(1.5).timeout
			shoot(angle_to_player+PI/4,400)
			shoot(angle_to_player-PI/4,400)
			shoot(angle_to_player+PI/8,400)
			shoot(angle_to_player-PI/8,400)
			shoot(angle_to_player+PI/16,400)
			shoot(angle_to_player-PI/16,400)
			shoot(angle_to_player+PI/32,400)
			shoot(angle_to_player-PI/32,400)
			
		
			
		
		await get_tree().create_timer(1.0).timeout
			
		for i in range(0,10):
			await get_tree().create_timer(0.8).timeout
			shoot(angle_to_player,500)
			shoot(angle_to_player+PI/8,600)
			shoot(angle_to_player-PI/8,600)
			await get_tree().create_timer(0.05).timeout
			shoot(angle_to_player+PI/8,600)
			shoot(angle_to_player-PI/8,600)
			await get_tree().create_timer(0.05).timeout
			shoot(angle_to_player+PI/8,600)
			shoot(angle_to_player-PI/8,600)
			await get_tree().create_timer(0.05).timeout
			shoot(angle_to_player+PI/8,600)
			shoot(angle_to_player-PI/8,600)
			
		await get_tree().create_timer(0.1).timeout
			
		for i in range(0,5):
			await get_tree().create_timer(0.7).timeout
			shoot(angle_to_player,500)
			shoot(angle_to_player+PI/64,500)
			shoot(angle_to_player-PI/64,500)
			shoot(angle_to_player+PI/32,500)
			shoot(angle_to_player-PI/32,500)
			
		
		await get_tree().create_timer(0.1).timeout
			

		for i in range(0,10):
			await get_tree().create_timer(1.0).timeout
			shoot(angle_to_player,400)
			shoot(angle_to_player+PI/8,400)
			shoot(angle_to_player-PI/8,400)
			shoot(angle_to_player+PI/16,400)
			shoot(angle_to_player-PI/16,400)
			shoot(angle_to_player+PI/32,400)
			shoot(angle_to_player-PI/32,400)
			
	
	


func _physics_process(delta: float) -> void:
	move_and_slide()
	angle_to_player = get_angle_to(player.position)


func shoot(angle,speed):
	var new_bullet = bullet_scn.instantiate()
	new_bullet.position = position
	new_bullet.speed = speed
	new_bullet.rotation = angle
	add_sibling(new_bullet)

func shoot_from_pos(angle,speed,pos):
	var new_bullet = bullet_scn.instantiate()
	new_bullet.position = pos
	new_bullet.speed = speed
	new_bullet.rotation = angle
	add_sibling(new_bullet)
	
func move_loop():
	while moving:
		move_dir *= -1
		velocity = Vector2(move_dir * speed,0)
		print(velocity)
		await get_tree().create_timer(3.0).timeout
	
