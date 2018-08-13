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

func portal_text():
	Ren.story_state = str(1)
	Ren.story_step()
	Globals.active_ren()

func story(dialog_name):
	if dialog_name != name:
		return

	if Ren.current_node != self:
		Ren.current_node = self

	match Ren.story_state:
		"0":
			Ren.say({
			"who":"dream",
			"what": """
				This is Gabe Renewal. He is your God! You will
				recommend good games for him and his players!
				"""
			})
		"1":
			Ren.say({
			"who":"dream",
			"what": """
				Get to the portal.
				"""
			})

