extends Node



func _on_TextureButton_pressed():
	Globals.GUI.startup()
	get_tree().change_scene_to(load("res://scenes/container.tscn"))
