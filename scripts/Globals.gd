extends Node
var score = 0 setget _set_score, _get_score
var killed = 0 setget _set_killed, _get_killed
var lvl3_score = 0 setget _set_lvl3_score, _get_lvl3_score
onready var GUI = $GUI

func _ready():
	Ren.define("score", score)
	Ren.define("killed", killed)
	Ren.define("lvl3_score", lvl3_score)
	GUI.update_gui(score)
	randomize()
	if OS.get_name() == "Android":
		GUI.set_mobile()
	else:
		pass

func _process(delta):
	var dead = get_tree().get_nodes_in_group("dead")
	for i in dead:
		i.queue_free()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_page_down"):
		get_tree().change_scene_to(load("res://scenes/level2.tscn"))
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().change_scene_to(load("res://scenes/level3.tscn"))

func toggle_music():
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing

func gameover():
	get_tree().change_scene_to(load("res://scenes/gameover.tscn"))

func start():
	score = 0
	killed = 0
	GUI.update_gui(score)
	get_tree().change_scene_to(load("res://scenes/level1.tscn"))

func _set_score(value):
	Ren.define("score", value)
	$GUI.update_gui(value)

func _get_killed():
	return Ren.get_value("killed")

func _set_killed(value):
	Ren.define("killed", value)

func _get_score():
	return Ren.get_value("score")

func _get_lvl3_score():
	return Ren.get_value("lvl3_score")

func _set_lvl3_score(value):
	Ren.define("lvl3_score", value)

func active_ren():
	GUI.show_ren()
