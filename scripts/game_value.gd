extends Label

@onready var h_slider_game: HSlider = $".."

func _ready() -> void:
	set_value()

func _on_h_slider_game_value_changed(value: float) -> void:
	set_value()

func set_value():
	if h_slider_game.value == 0:
		text = "random"
	elif h_slider_game.value == 1:
		text = "tic tac toe"
	else:
		text = "de bom"
