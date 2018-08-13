extends "res://scripts/startup.gd"

func _ready():
	Globals.disable_ren()
	Globals.ren_avatar.free()
	$CenterContainer/VBoxContainer/score.text = str("You collected ",str(Globals.score + Globals.killed + Globals.lvl3_score)," games")



