extends Area2D


@export var next_scene : PackedScene


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(next_scene)
