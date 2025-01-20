extends Area2D


@export var SPEED = 2.0
@export var ACCEL = 4.0
@export var HP = 100

var attack_distance := 250

@export var target : Node2D
var velocity := Vector2(0, 0)

@onready var navigation : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	$DemageTreckerLabel.text = ""

func _physics_process(delta: float) -> void:
	navigation.target_position = target.global_position

	var next_pos = navigation.get_next_path_position()
	var direction = next_pos - global_position
	direction = direction.normalized()
		
	velocity = velocity.lerp(direction*SPEED, ACCEL*delta)
		
	$AnimatedSprite2D.look_at(next_pos)
	$AnimatedSprite2D.rotate(PI/2)
	$CollisionShape2D.look_at(next_pos)
	$CollisionShape2D.rotate(PI/2)
	
		
	global_position += velocity
	
	if GameManager.player:
		var distance_from_player = (global_position - GameManager.player.global_position).length()
		
		if distance_from_player < attack_distance and %AttackTimer.is_stopped():
			%AttackTimer.start()
		elif distance_from_player > attack_distance:
			%AttackTimer.stop()


func on_hit(damage):
	HP = HP - damage
	if HP <= 0:
		queue_free()
	else:
		$DemageTreckerLabel.text = str(-damage)
		await get_tree().create_timer(0.25).timeout
		$DemageTreckerLabel.text = ""

func _on_attack_timer_timeout() -> void:
	$AnimatedSprite2D.play("attack")
	GameManager.player.on_hit(10)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "attack":
		$AnimatedSprite2D.play("default")


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "attack":
		$AnimatedSprite2D.play("default")
