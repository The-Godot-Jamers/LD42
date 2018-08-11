extends CanvasLayer

func update_gui(value):
	$TextureRect/HBoxContainer/Label.text = str(value)
	$AnimationPlayer.play("bling")

func _on_left_pressed():
	Input.action_press("ui_left")


func _on_right_pressed():
	Input.action_press("ui_right")

func _on_up_pressed():
	Input.action_press("ui_up")

