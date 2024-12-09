extends CharacterBody2D


@export var SPEED = 90.0
@export var ACCEL = 8.0

@export var target : Node2D


@onready var navigation : NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	navigation.target_position = target.global_position

	var next_pos = navigation.get_next_path_position()
	var direction = next_pos - global_position
	direction = direction.normalized()
		
	velocity = velocity.lerp(direction*SPEED, ACCEL*delta)
		
	look_at(next_pos)
		
	move_and_slide()

	
