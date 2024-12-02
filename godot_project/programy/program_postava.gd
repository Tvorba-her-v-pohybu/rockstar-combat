extends CharacterBody2D


@export var tricet := 30

@export var speed := 200.0
@export var ammo := tricet
@export var reloading := false
@export var strelba := false

var projectile_scene := preload("res://projectile.tscn")

func _ready() -> void:
	show_ammo()

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
	if Input.is_action_just_pressed("mouse_left") && ammo > 0 && reloading == false && strelba == false:
		strelba = true
		_shoot()
		$AudioStreamPlayer2.play()
		ammo = ammo - 1
		show_ammo()
		await get_tree().create_timer(0.2).timeout
		strelba = false
	if Input.is_action_just_pressed("R_key") && ammo < tricet:
		reloading = true
		ammo = 0
		show_ammo()
		$AudioStreamPlayer3.play()
		await get_tree().create_timer(3.25).timeout
		ammo = tricet
		show_ammo()
		reloading = false

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

	
	move_and_slide()

func show_ammo():
	%AmmoLabel.text = str(ammo) + " / " + str(tricet)
# Tahle funkce provede strileni
func _shoot():
	var projectile := projectile_scene.instantiate()
	projectile.global_position = $Node2D.global_position
	projectile.rotation = rotation
	$"..".add_child(projectile)
