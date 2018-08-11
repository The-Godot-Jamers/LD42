extends Sprite

export var ghost_time = 0.6

func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), ghost_time,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()
