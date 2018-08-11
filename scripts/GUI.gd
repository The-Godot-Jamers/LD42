extends CanvasLayer

func update_gui(value):
	$TextureRect/HBoxContainer/Label.text = str(value)
	$AnimationPlayer.play("bling")