extends Sprite

export var ghost_time = 0.6
export var ghost_alpha_start = 0.5
export var ghost_alpha_end = 0.1

func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, ghost_alpha_start), Color(1, 1, 1, ghost_alpha_end), ghost_time,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()
