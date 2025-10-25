extends Node2D

var hp = 3

func _ready() -> void:
	pass
	
	
	
	
	
	
func _physics_process(delta: float) -> void:
	if(hp <= 0):
		die()
		










func die():
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	body.queue_free()
	hp -= 1
