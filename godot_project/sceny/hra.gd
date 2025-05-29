extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%hrac.smrt.connect(_schovej_srdce.bind())

func _schovej_srdce(zivoty):
	match zivoty:
		2:
			$CanvasLayer/SrdceFialove3.visible = false
		1:
			$CanvasLayer/SrdceFialove2.visible = false
		0:
			$CanvasLayer/SrdceFialove.visible = false
			get_tree().change_scene_to_file("res://sceny/hra2.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
