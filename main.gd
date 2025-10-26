extends Node2D

var dead:bool = false

func start_game():
	get_tree().call_group("element", "queue_free")
	

func _physics_process(delta: float) -> void:
	if(dead == true):
		pass

func _on_player_die():
	dead = true
