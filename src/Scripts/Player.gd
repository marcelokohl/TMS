extends CharacterBody2D

const speed = 60.0

func _physics_process(delta):

	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	if directionX:
		velocity.x = directionX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if directionY:
		velocity.y = directionY * speed 
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
