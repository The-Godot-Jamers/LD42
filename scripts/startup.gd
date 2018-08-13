extends Node


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_on_start_pressed()

func _on_start_pressed():
	$AudioStreamPlayer.play()
	Globals.GUI.startup()
	Globals.start()
	Globals.score = 0
	Globals.killed = 0
	Globals.lvl3_score = 0
	

func _on_music_pressed():
	$AudioStreamPlayer.play()
	Globals.toggle_music()
	var i = $CenterContainer/VBoxContainer/music/TextureRect
	i.modulate = Color(1-i.modulate.r, 1-i.modulate.g, i.modulate.b, i.modulate.a)


func _on_quit_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()