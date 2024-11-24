extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2(0, -1).rotated(global_rotation)
	global_position += direction.normalized() * 1500 * delta



func _on_body_entered(body: Node2D) -> void:
	queue_free()
