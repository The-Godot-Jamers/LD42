extends "res://scripts/startup.gd"

func _ready():
	$CenterContainer/VBoxContainer/score.text = str("You collected ",str(Globals.score)," games")



