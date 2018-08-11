extends RigidBody2D

export var bottom = 700

onready var sprite = $sprite
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
		Globals.score += 1
		Globals.GUI.update_gui(Globals.score)
		$AnimationPlayer.play("bling")
		$bling.play()
		picked = true
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
