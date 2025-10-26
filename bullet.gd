extends CharacterBody2D
@export var speed = 100
@export var dmg = 1
@export var size = Vector2(1,1)


func _ready() -> void:
	velocity = Vector2(speed,0).rotated(rotation)
	
	await get_tree().create_timer(10.0).timeout
	
	queue_free()
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	
