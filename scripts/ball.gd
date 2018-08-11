extends RigidBody2D

onready var sprite = $sprite

func remove_pickup():
	$pickup_area.queue_free()
	

func _on_pickup_area_body_entered(body):
	Globals.score += 1
	Globals.GUI.update_gui(Globals.score)
	$AnimationPlayer.play("bling")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
