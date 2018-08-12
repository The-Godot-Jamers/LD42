extends Node

var parent
var random_max = 5

func _ready():
	Ren.connect("story_step", self, "story")

func on_active_dialog():
	Ren.jump(
		"enemy",
		parent,
		str(get_random()),
		false
	)
	Ren.start()

func get_random():
	randomize()
	return randi() % random_max + 1

func random_say(what):
	Ren.say({
		"who":"enemy",
		"what": what
	})
	Ren.story_state = str(get_random())

func story(dialog_name):
	if dialog_name != parent:
		return
	
	if Ren.current_node != self:
		Ren.current_node = self

	match Ren.story_state:
		"0":
			random_say("Hi, sexy I have game for you ;) .")
		
		"1":
			random_say("The Legend Of Esmeralda!")
		
		"2":
			random_say("This game is about hot gamer girl you would want to beat you at everything.")
		
		"3":
			random_say("Break out your BFG, Big Flowers Grande.")

		"4":
			random_say("Babies Unknown: Rattle Grounds. Kill other babies with rattles.")
		
		"5":
			random_say("Buy my awesome game!")
		
		
		