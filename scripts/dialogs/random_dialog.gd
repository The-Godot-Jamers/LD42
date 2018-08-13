extends Node

var random_max = 17

func _ready():
	Ren.connect("story_step", self, "story")

func on_active_dialog():
	Ren.jump(
		"enemy",
		"random",
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
	if dialog_name != "random":
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
		
		"6":
			random_say("Online battleroyle, roguelike, open world!")
		
		"7":
			random_say("Mood 2: Heaven on earth!")
		
		"8":
			random_say("Alley fighter 2: Super Mega Ultra DX Giga Ultimate volume 3!")
		
		"9":
			random_say("Infinite Bingo Crime Scene Investigation!")
		
		"10":
			random_say("Geriatric Bazooka Orchestra!")
		
		"11":
			random_say("ZEXE: Friend known")
		
		"12":
			random_say("Cow simulator")
		
		"13":
			random_say("STS: Slower than sound")
		
		"14":
			random_say("Wrath of the Pachinko Horde")
		
		"15":
			random_say("Iron Pogo Melee")
		
		"16":
			random_say("Iron Pogo Melee")
		
		"17":
			random_say("The Binding of Samuel Jackson")
		