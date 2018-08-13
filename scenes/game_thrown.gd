extends RigidBody2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$AnimatedSprite.animation = "boom"
		Globals.GUI.hide()
		Globals.gameover()
	queue_free()
