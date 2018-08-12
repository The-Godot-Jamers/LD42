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
	Globals.active_ren()

func story(dialog_name):
	if dialog_name != name:
		return
	
	if Ren.current_node != self:
		Ren.current_node = self

	match Ren.story_state:
		"0":
			Ren.say({
			"what": """
				Welcome new bot currator in Dream digital shop for games.
				Your job is to collet the best games for our players.
				You need to 15 collect boxes with good games.
				"""
			})
			
		