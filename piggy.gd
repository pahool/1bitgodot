extends Area2D

@export var speed = 100

func _process(delta):
	
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += input_vector * speed * delta
