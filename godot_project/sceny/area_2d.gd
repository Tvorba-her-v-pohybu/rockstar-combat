extends Area2D


@export var SPEED = 2.0
@export var ACCEL = 4.0
@export var HP = 100

@export var target : Node2D
var velocity := Vector2(0, 0)

@onready var navigation : NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	navigation.target_position = target.global_position

	var next_pos = navigation.get_next_path_position()
	var direction = next_pos - global_position
	direction = direction.normalized()
		
	velocity = velocity.lerp(direction*SPEED, ACCEL*delta)
		
	look_at(next_pos)
		
	global_position += velocity

func on_hit(damage):
	HP = HP - damage
	if HP == 0:
		queue_free()
		
