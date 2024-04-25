extends CharacterBody2D

@export var move_speed : float = 100


func _physics_process(_delta):
	
	var input_direction = Vector2(
	Input.get_action_strength("Down") - Input.get_action_strength("Up"),
	Input.get_action_strength("Left`") - Input.get_action_strength("Right")
	)
	print(input_direction)
	velocity = input_direction + move_speed
	
	move_and_slide()



