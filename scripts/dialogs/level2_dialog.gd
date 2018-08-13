extends Node

func _ready():
	Ren.connect("story_step", self, "story")
	Ren.jump(
		"intro",
		name,
		str(0),
		false
	)
	Ren.start()
	# Globals.active_ren()

func story(dialog_name):
	if dialog_name != name:
		return
	
	if Ren.current_node != self:
		Ren.current_node = self

	match Ren.story_state:
		"0":
			Ren.say({
			"who": "dream"
			"what": """
				Your next task is to kill bots that try to sell bad games.
				"""
			})
			
		