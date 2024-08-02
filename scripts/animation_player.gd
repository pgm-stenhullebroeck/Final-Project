extends AnimationPlayer

func _ready():
	pass

func _on_check_btn_button_down():
	play("press")


func _on_check_btn_button_up():
	play("RESET")
