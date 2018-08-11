extends RigidBody2D

export var bottom = 700

onready var sprite = $sprite
var picked = false

func remove_pickup():
	$pickup_area.queue_free()

func _physics_process(delta):
	if position.y >= bottom:
		Globals.GUI.hide()
		get_tree().change_scene_to(load("res://scenes/gameover.tscn"))

func _on_pickup_area_body_entered(body):
	if not picked:
		Globals.score += 1
		Globals.GUI.update_gui(Globals.score)
		$AnimationPlayer.play("bling")
		$AudioStreamPlayer.play()
		picked = true
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
