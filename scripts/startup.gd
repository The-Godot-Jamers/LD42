extends Node


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_on_TextureButton_pressed()
func _on_TextureButton_pressed():
	$AudioStreamPlayer.play()
	Globals.GUI.startup()
	get_tree().change_scene_to(load("res://scenes/container.tscn"))
