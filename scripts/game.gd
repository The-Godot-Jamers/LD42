extends RigidBody2D

export var bottom = 700

onready var sprite = $sprite
onready var sprite2 = $sprite/sprite

var picked = false

func remove_pickup():
	$pickup_area.queue_free()

func _physics_process(delta):
	if position.y >= bottom:
		if is_in_group("ghostly"):
			queue_free()
			return
		$wompwomp.play()
		Globals.GUI.hide()
		Globals.gameover()

func _on_pickup_area_body_entered(body):
	if not picked:
		if Globals.lvl == 1:
			Globals.score += 1
			Globals.GUI.update_gui(Globals.score + Globals.killed + Globals.lvl3_score)
		elif Globals.lvl == 3:
			Globals.lvl3_score +=1
			Globals.GUI.update_gui(Globals.score + Globals.killed + Globals.lvl3_score)
		$AnimationPlayer.play("bling")
		$bling.play()
		picked = true
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
