extends Node
var score = 0
onready var GUI = $GUI

func _ready():
	GUI.update_gui(score)
	randomize()
	if OS.get_name() == "Android":
		pass
	else:
		pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_focus_prev"):
		get_tree().reload_current_scene()
