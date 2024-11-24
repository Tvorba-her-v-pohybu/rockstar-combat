extends CharacterBody2D

@export var speed := 200.0

var projectile_scene := preload("res://projectile.tscn")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation += PI/2
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("mouse_left"):
		_shoot()
		$AudioStreamPlayer2.play()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

	
	move_and_slide()

func _shoot():
	var projectile := projectile_scene.instantiate()
	projectile.global_position = $Node2D.global_position
	projectile.rotation = rotation
	$"..".add_child(projectile)
