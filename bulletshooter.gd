extends CharacterBody2D

var bullet_scn = preload("res://bullet.tscn")
var angle_to_player = 0
@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	for i in range(0,5):
		await get_tree().create_timer(0.5).timeout
		shoot(angle_to_player,200)
		
	


func _physics_process(delta: float) -> void:
	angle_to_player = get_angle_to(player.position)


func shoot(angle,speed):
	var new_bullet = bullet_scn.instantiate()
	new_bullet.position = position
	new_bullet.speed = speed
	new_bullet.rotation = angle
	add_sibling(new_bullet)
	print("shot")
	
