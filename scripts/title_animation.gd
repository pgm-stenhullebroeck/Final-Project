extends AnimationPlayer

func _ready():
	play("flicker")


func _on_title_play_pressed():
	play("fast_flicker")
