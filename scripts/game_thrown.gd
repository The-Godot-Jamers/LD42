extends RigidBody2D



func _on_Area2D_body_entered(body):
	$AnimatedSprite.animation = "boom"
	$Timer.start()
	if body.is_in_group("player"):
		print("player")
		Globals.GUI.hide()
		Globals.gameover()


func _on_Timer_timeout():
	queue_free()
	