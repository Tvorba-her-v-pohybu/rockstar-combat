extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%hrac.smrt.connect(_schovej_srdce.bind())

func _schovej_srdce():
	
	$CanvasLayer/SrdceFialove.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
