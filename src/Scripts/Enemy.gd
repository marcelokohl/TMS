extends CharacterBody2D

@export var movement_speed : float = 40

@export var movement_target : Node2D  

@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D 

var current_target_pos : Vector2

func _ready():
	add_to_group("enemy")
	call_deferred("actor_setup")
	var timer = $Timer
	timer.wait_time = 1  # Atualiza a rota a cada 1 segundo
	timer.autostart = true
	timer.timeout.connect(self._on_timer_timeout)
	
func actor_setup():
	await get_tree().physics_frame 
	
	if movement_target != null:
		set_movement_target(movement_target.position)
	else:
		
		movement_target = get_parent().get_node("Player")
		if movement_target != null:
			set_movement_target(movement_target.position)
		else: 
			printerr("movement target == null")

func set_movement_target(target: Vector2):
	current_target_pos = target
	navigation_agent.target_position = target
	
func test():
	return
	
func _process(delta):
	
	var cur_agent_position : Vector2 = global_position 
	var next_path_position : Vector2 = navigation_agent.get_next_path_position()
	
	var new_velocity : Vector2 = next_path_position - cur_agent_position 
	new_velocity = new_velocity.normalized() * movement_speed
	
	velocity = new_velocity
	move_and_slide()


func _on_timer_timeout():
	if movement_target == null:
		return

	if movement_target.position != current_target_pos:
		set_movement_target(movement_target.position)
	
	if navigation_agent.is_navigation_finished():
		return 
	#pass # Replace with function body.
