extends RigidBody2D



func _on_Area2D_body_entered(body):
	$AnimatedSprite.animation = "boom"
	if body.is_in_group("player"):
		Globals.GUI.hide()
		Globals.gameover()
	queue_free()
