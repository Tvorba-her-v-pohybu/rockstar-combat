class_name Player extends CharacterBody2D

signal smrt

@export var tricet := 30

@export var speed := 200.0
@export var ammo := tricet
@export var reloading := false
@export var strelba := false
@export var hp := 100
@export var zivoty := 3
@export var naboje = tricet * 8

var start_position : Vector2

var projectile_scene := preload("res://sceny/projectile.tscn")

func _ready() -> void:
	start_position = global_position
	
	GameManager.player = self
	show_ammo()
	show_hp()

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
	if Input.is_action_pressed("mouse_left") && ammo > 0 && reloading == false && strelba == false:
		strelba = true
		_shoot()
		$AudioStreamPlayer2.play()
		ammo = ammo - 1
		show_hp()
		show_ammo()
		await get_tree().create_timer(0.2).timeout
		strelba = false
	if Input.is_action_just_pressed("R_key") && naboje > 0:
		reloading = true
		naboje = naboje - tricet
		ammo = 0
		show_ammo()
		$AudioStreamPlayer3.play()
		await get_tree().create_timer(3.25).timeout
		ammo = tricet
		show_ammo()
		reloading = false
	if Input.is_action_just_pressed("Shift_left"):
		speed = 300.0
	if Input.is_action_just_released("Shift_left"):
		speed = 200.0
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()
	if hp < 1:
		zivoty = zivoty - 1
		smrt.emit(zivoty)
		hp = 100
		show_hp()
		$AudioStreamPlayer4.play()
		global_position = start_position
		naboje = naboje - 20
		show_ammo()
	move_and_slide()

func show_ammo():
	%AmmoLabel.text = str(ammo) + " / " + str(naboje) + " "
	
func on_hit(damage):
	hp = hp - damage
	show_hp()
	
func show_hp():
	%HPLabel.text = str(hp)
func _shoot():
	var projectile := projectile_scene.instantiate()
	projectile.global_position = $Node2D.global_position
	projectile.rotation = rotation
	$"..".add_child(projectile)
