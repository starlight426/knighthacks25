extends Area2D
var number
var enemies_in_area = []
signal update_parent_number(new_number)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	update_number(enemies_in_area.size())
	
func detection_area_entered(body):
	enemies_in_area.append(body)

	
func detection_area_exited(body):
	enemies_in_area.erase(body)
	


func update_number(new_number):
	update_parent_number.emit(new_number)
	number = new_number	
