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

func portal_text():
	Ren.story_state = str(1)
	Ren.story_step()
	#Globals.active_ren()

func story(dialog_name):
	if dialog_name != name:
		return
	
	if Ren.current_node != self:
		Ren.current_node = self

	match Ren.story_state:
		"0":
			Ren.say({
			"who": "dream",
			"what": """
				Your next task is to kill bots that try to sell bad games.
				Jump on their heads, but don't touch them or their bad games!
				"""
			})
		"1":
			Ren.say({
			"who":"dream",
			"what": """
				Get to the portal.
				"""
			})
			
			
		