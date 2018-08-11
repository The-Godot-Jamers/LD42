extends Node
var score = 0
onready var GUI = $GUI

func _ready():
	GUI.update_gui(score)
	randomize()
	if OS.get_name() == "Android":
		GUI.set_mobile()
	else:
		pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_focus_prev"):
		get_tree().reload_current_scene()

func toggle_music():
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing

func gameover():
	get_tree().change_scene_to(load("res://scenes/gameover.tscn"))

func start():
	get_tree().change_scene_to(load("res://scenes/container.tscn"))