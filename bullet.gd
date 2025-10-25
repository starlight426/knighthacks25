extends CharacterBody2D
@export var speed = 100
@export var dmg = 1
@export var size = Vector2(1,1)


func _ready() -> void:
	velocity = Vector2(speed,0).rotated(rotation)
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	
