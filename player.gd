extends Node2D

var hp = 3

signal player_die


#data
var closest_bullet = null


#parameters
var angle_to_closest_bullet = 0
var distance_from_closest_bullet = 10000
var left_has_more_bullets = false
var right_has_more_bullets = false
var how_long_closest_bullet_has_been_closest = 0


func _ready() -> void:
	pass
	
	
	
func _physics_process(delta: float) -> void:
	
	if(hp <= 0):
		die()
	
	#update data
	
	
	
	
	#update parameters
		
		
		
	
func die():
	player_die.emit()
	pass
	
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	body.queue_free()
	hp -= 1
	print(hp)
